//
//  UserManager.swift
//  Subtuner
//
//  Created by Untitled on 5/12/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import Foundation

class UserManager {
    
    var core: Core!
    lazy var userFileURL: URL? = {
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = directoryURL.appendingPathComponent("user.json")
        print(fileURL)
        return fileURL
    }()
    var _user: User?
    var user: User? {
        get {
            do {
                guard let userFileURL = userFileURL else { return nil }
                let data = try Data(contentsOf: userFileURL)
                return try JSONDecoder().decode(User.self, from: data)
            } catch {
                print(error)
                return nil
            }
        }
        set {
            guard let userFileURL = userFileURL else { return }
            do {
                let data = try JSONEncoder().encode(newValue)
                try data.write(to: userFileURL)
            } catch {
                print(error)
            }
        }
    }
}
