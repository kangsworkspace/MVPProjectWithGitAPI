//
//  Network+Method.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

import Moya

extension Network {
    func getMethod() -> Moya.Method {
        switch self {
        case .login:
            return .get
        case .getToken:
            return .post
        case .gitUserInfo:
            return .get

        }
    }
}
