//
//  UserRequest.swift
//  DoorsConsole
//
//  Created by Igor Leonovich on 5/11/20.
//  Copyright © 2020 IELIS. All rights reserved.
//

import Foundation

struct UserRequest: Codable {
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
}
