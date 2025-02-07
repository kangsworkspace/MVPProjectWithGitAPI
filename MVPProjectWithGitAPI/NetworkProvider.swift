//
//  NetworkProvider.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import UIKit

import Moya

final class NetworkProvider {
    // MARK: - Field
    static var shared = NetworkProvider()
    private let provider: MoyaProvider<Network>
    private var accessToken = ""
    
    // MARK: - Life Cycles
    init(provider: MoyaProvider<Network> = MoyaProvider<Network>()) {
        self.provider = provider
    }
    
    // MARK: - Functions
    /// 깃 로그인
    func login() {
        provider.request(.login) { result in
            switch result {
            case .success(let response):
                if let url = response.request?.url {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case .failure(let error):
                print("GitHub 로그인을 시작하지 못했습니다:", error)
            }
        }
    }
    
    /// AccessToken 가져오기
    /// - Parameter tempCode:(String) : 로그인을 통해 가져온 임시 코드
    func fetchAccessToken(tempCode: String) {
        provider.request(.getToken(tempCode: tempCode)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] else { return }
                    self?.accessToken = (json["access_token"] as? String)!
                } catch let error {
                    print("Error parsing response: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    /// 유저 정보 가져오기
    /// - Parameter userID: 검색할 유저의 ID 값
    /// - Parameter page: 페이지 값(Pagination 처리)
    func fetchUserData(userID: String, page: Int?, completion: @escaping(UserInfoList?) -> Void) {
        provider.request(.gitUserInfo(accessToken: accessToken, userID: userID, page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    guard let jsonString = String(data: response.data, encoding: .utf8) else { return }
                    guard let jsonData = jsonString.data(using: .utf8) else { return }
                    
                    // 디코드
                    let decoder = JSONDecoder()
                    let resultArray = try decoder.decode(UserInfoList.self, from: jsonData)
                    
                    completion(resultArray)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
