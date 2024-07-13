//
//  UserInfo.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

struct UserInfoList: Codable {
    /// 유저 데이터 정보
    let userInfo: [UserInfo]

    enum CodingKeys: String, CodingKey {
        case userInfo = "items"
    }
}

// MARK: - Item
struct UserInfo: Codable {
    let login: String
    let avatarURL: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case url = "html_url"
    }
}
