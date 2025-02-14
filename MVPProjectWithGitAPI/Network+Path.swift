//
//  Network+Path.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

extension Network {
    func getPath() -> String {
        switch self {
        case .login:
            return "/login/oauth/authorize"
        case .getToken:
            return"/login/oauth/access_token"
        case .gitUserInfo:
            return "/search/users"
        }
    }
}

