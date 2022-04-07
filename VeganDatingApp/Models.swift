//
//  Models.swift
//  VeganDatingApp
//
//  Created by Atli Saevar on 7.4.2022.
//

import Foundation

struct AuthData: Decodable {
    let token: String!
}

struct Auth: Decodable {
    let data: AuthData!
}

struct LoginResponse: Decodable {
    let status: Int!
    let status_desc: String!
    let auth: Auth!
}

struct User: Decodable {
    let name: String!
    let date_of_birth: Int!
    let profile_image: String!
}

struct MetaData: Decodable {
    let item_count: Int!
    let total_pages: Int!
    let current_page: Int!
}

struct UserData: Decodable {
    let users: [User]!
    let meta: MetaData!
}

struct UserResponse: Decodable {
    let status: Int!
    let status_desc: String!
    let data: UserData!
}
