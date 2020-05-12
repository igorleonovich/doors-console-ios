//
//  AuthManager.swift
//  Subtuner
//
//  Created by Untitled on 5/11/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

class AuthManager {
    
    var core: Core!
    var secureStoreWithGenericPwd: SecureStore!
    
    lazy var sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        return config
    }()
    
    var signUpDataTask: URLSessionDataTask?
    var logInDataTask: URLSessionDataTask?
    
    init() {
        let genericPwdQueryable = GenericPasswordQueryable(service: "Subtuner")
        secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPwdQueryable)
    }
    
    func signUp(newUser: NewUser, completion: @escaping (Swift.Error?) -> Void) {
        signUpDataTask?.cancel()
        
        let sessionDelegate = SessionDelegate()
        let session = URLSession(configuration: sessionConfiguration, delegate: sessionDelegate, delegateQueue: OperationQueue.main)
        // TODO: Change main queue
        
        guard let url = URL(string: "\(Constants.baseURL)users/register") else {
            return
        }
        var request = URLRequest(url: url)
        do {
            let data = try JSONEncoder().encode(newUser)
            request.httpMethod = "POST"
            request.httpBody = data
            signUpDataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
                guard let `self` = self else { return }
                defer {
                    self.signUpDataTask = nil
                }
                if let error = error {
                    completion(error)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let signUpResponse = try JSONDecoder().decode(LogInSignUpResponse.self, from: data)
                            try self.secureStoreWithGenericPwd.setValue(signUpResponse.accessToken, for: "accessToken")
                            try self.secureStoreWithGenericPwd.setValue(signUpResponse.refreshToken, for: "refreshToken")
                            self.core.userManager.user = signUpResponse.user
                            completion(nil)
                        } catch {
                            completion(error)
                        }
                    } else if let error = error {
                        completion(error)
                    } else {
                        do {
                            let serverError = try JSONDecoder().decode(ServerError.self, from: data)
                            let error = Error.serverError(reason: serverError.reason)
                            completion(error)
                        } catch {
                            completion(error)
                        }
                    }
                }
            }
            signUpDataTask?.resume()
        } catch {
            completion(error)
        }
    }
    
    func logIn(login: Login, _ completion: @escaping (Swift.Error?) -> Void) {
       logInDataTask?.cancel()
        
        let sessionDelegate = SessionDelegate()
        let session = URLSession(configuration: sessionConfiguration, delegate: sessionDelegate, delegateQueue: OperationQueue.main)
        // TODO: Change main queue
        
        guard let url = URL(string: "\(Constants.baseURL)users/login") else {
            return
        }
        var request = URLRequest(url: url)
        do {
            let data = try JSONEncoder().encode(login)
            request.httpMethod = "POST"
            request.httpBody = data
            logInDataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
                guard let `self` = self else { return }
                defer {
                    self.logInDataTask = nil
                }
                if let error = error {
                    completion(error)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let logInResponse = try JSONDecoder().decode(LogInSignUpResponse.self, from: data)
                            try self.secureStoreWithGenericPwd.setValue(logInResponse.accessToken, for: "accessToken")
                            try self.secureStoreWithGenericPwd.setValue(logInResponse.refreshToken, for: "refreshToken")
                            self.core.userManager.user = logInResponse.user
                            completion(nil)
                        } catch {
                            completion(error)
                        }
                    } else if let error = error {
                        completion(error)
                    } else {
                        do {
                            let serverError = try JSONDecoder().decode(ServerError.self, from: data)
                            let error = Error.serverError(reason: serverError.reason)
                            completion(error)
                        } catch {
                            completion(error)
                        }
                    }
                }
            }
            logInDataTask?.resume()
        } catch {
            completion(error)
        }
    }
    
    func logOut(_ completion: @escaping (Swift.Error?) -> Void) {
        do {
            try self.secureStoreWithGenericPwd.removeValue(for: "accessToken")
            try self.secureStoreWithGenericPwd.removeValue(for: "refreshToken")
            core.userManager.user = nil
            completion(nil)
        } catch {
            completion(error)
        }
    }
}

class SessionDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential, nil)
    }
}

extension AuthManager {
    indirect enum Error: Swift.Error {
        case someError(error: Error)
        case serverError(reason: String)
    }
}

extension AuthManager.Error: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(let reason):
            return reason
        case .someError(let error):
            return error.localizedDescription
        }
    }
}
