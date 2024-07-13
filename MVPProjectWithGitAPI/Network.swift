//
//  Network.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

import Moya

enum Network {
    /// 깃 로그인
    case login
    
    /// RestAPI를 사용하기 위해 Git 토큰 가져오기
    /// - Parameter tempCode: 깃 로그인으로 획득한 임시 토큰
    case getToken(tempCode: String)
    
    /// Rest API로 유저의 정보를  가져오는 경우
    /// - Parameter accessToken: API 사용을 위한 토큰(깃 로그인으로 획득)
    /// - Parameter userID:(Int) : 검색할 유저의 아이디
    /// - Parameter page:(Int) : 페이징 처리를 위한 페이지 값
    case gitUserInfo(accessToken: String, userID: String, page: Int?)
}

extension Network: TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var task: Task { self.getTask() }
    var headers: [String : String]? { self.getHeader() }
}
