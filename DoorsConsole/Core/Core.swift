//
//  Core.swift
//  DoorsConsole
//
//  Created by Igor Leonovich on 5/9/20.
//  Copyright © 2020 IELIS. All rights reserved.
//

import Foundation

class Core {
    
    var authManager = AuthManager()
    var userManager = UserManager()
    
    lazy var signedSessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        return config
    }()
    
    init() {
        authManager.core = self
        userManager.core = self
    }
}
