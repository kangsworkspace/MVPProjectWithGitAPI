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
}

extension Network: TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var task: Task { self.getTask() }
    var headers: [String : String]? { self.getHeader() }
}
