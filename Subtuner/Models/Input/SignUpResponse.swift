//
//  SignUpResponse.swift
//  Subtuner
//
//  Created by Untitled on 5/11/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

struct SignUpResponse: Codable {
    let status: String
    let user: User
    let refreshToken: String
    let accessToken: String
}
