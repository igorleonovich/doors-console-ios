//
//  Core.swift
//  Subtuner
//
//  Created by Untitled on 5/9/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

class Core {
    let authManager = AuthManager()
    let userManager = UserManager()
    
    init() {
        authManager.core = self
        userManager.core = self
    }
}
