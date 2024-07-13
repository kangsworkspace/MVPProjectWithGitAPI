//
//  Extensions.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

extension Bundle {
    var cliendID: String? {
        return infoDictionary?["CLIENT_ID"] as? String
    }
    
    var clientSecrets: String? {
        return infoDictionary?["CLIENT_SECRETS"] as? String
    }
}
