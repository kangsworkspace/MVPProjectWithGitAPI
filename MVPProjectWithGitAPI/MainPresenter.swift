//
//  MainPresenter.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

protocol MainViewInput {
    func bindView(view: MainViewOutput)
    func searchUser(userID: String)
    func getUserInfos() -> [UserInfo]
    func getNumberOfUserInfos() -> Int
    func clearButtonTapped()
}

final class MainPresenter {
    // MARK: - Field
    weak var view: MainViewOutput?
    private var networkProvider = NetworkProvider.shared
    private var userInfo: [UserInfo] = []
    
    // MARK: - Life Cycles
    init() {
        networkProvider.login()
    }
}

// MARK: - Extensions
extension MainPresenter: MainViewInput {
    func bindView(view: any MainViewOutput) {
        self.view = view
    }
    
    func searchUser(userID: String) {
        networkProvider.fetchUserData(userID: userID, page: nil) {[weak self] userInfoList in
            guard let userInfoArray = userInfoList?.userInfo else { return }
            self?.userInfo = userInfoArray
            self?.view?.reloadTableView()
        }
    }
    
    func getUserInfos() -> [UserInfo] {
        return userInfo
    }
    
    func getNumberOfUserInfos() -> Int {
        return userInfo.count
    }
    
    func clearButtonTapped() {
        view?.clearTextField()
    }
}
