//
//  AuthManager.swift
//  Subtuner
//
//  Created by Untitled on 5/11/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

class AuthManager {
    
    var secureStoreWithGenericPwd: SecureStore!
    
    lazy var sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        return config
    }()
    
    var signUpDataTask: URLSessionDataTask?
    
    init() {
        let genericPwdQueryable = GenericPasswordQueryable(service: "Subtuner")
        secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPwdQueryable)
    }
    
    func signUp(newUser: NewUser, completion: @escaping () -> Void) {
        signUpDataTask?.cancel()
        
        let session = URLSession(configuration: sessionConfiguration)
        guard let url = URL(string: "\(Constants.baseURL)users/register") else {
            return
        }
        var request = URLRequest(url: url)
        do {
            let data = try JSONEncoder().encode(newUser)
            request.httpMethod = "POST"
            request.httpBody = data
            signUpDataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
                defer {
                    self?.signUpDataTask = nil
                }
                if let error = error {
                    print(error)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                            print(signUpResponse)
                        } catch {
                            print(error)
                        }
                    } else {
                        print(response.statusCode)
                    }
                }
            }
            signUpDataTask?.resume()
        } catch {
            print(error)
        }
    }
    
    func logIn() {
        do {
            try secureStoreWithGenericPwd.setValue("accessToken", for: "accessToken")
            try secureStoreWithGenericPwd.setValue("refreshToken", for: "refreshToken")
        } catch {
            print(error)
        }
    }
}
