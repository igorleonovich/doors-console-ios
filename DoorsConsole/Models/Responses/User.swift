//
//  User.swift
//  DoorsConsole
//
//  Created by Igor Leonovich on 5/11/20.
//  Copyright © 2020 IELIS. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: UUID
    let username: String
    let email: String
    let isAdmin: Bool
}
