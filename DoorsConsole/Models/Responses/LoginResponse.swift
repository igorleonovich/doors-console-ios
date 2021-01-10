//
//  SignUpResponse.swift
//  DoorsConsole
//
//  Created by Igor Leonovich on 5/11/20.
//  Copyright © 2020 IELIS. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let user: User
    let refreshToken: String
    let accessToken: String
}
