//
//  ServerError.swift
//  Subtuner
//
//  Created by Untitled on 5/11/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

struct ServerError: Codable {
    let error: Bool
    let reason: String
}
