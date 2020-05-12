//
//  RefreshTokenInput.swift
//  Subtuner
//
//  Created by Untitled on 5/12/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

struct RefreshTokenInput: Codable {
    let status: String
    let accessToken: String
}
