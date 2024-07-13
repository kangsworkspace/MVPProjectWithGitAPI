//
//  Network+Header.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

extension Network {
    func getHeader() -> [String : String]? {
        switch self {
        case .login:
            return nil
        case .getToken:
            return ["Accept": "application/json"]
        }
    }
}
