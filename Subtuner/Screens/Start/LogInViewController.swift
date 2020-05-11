//
//  LoginViewController.swift
//  Subtuner
//
//  Created by Untitled on 5/9/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import UIKit

class LogInViewController: BaseViewController {
    
    let core: Core
    
    init(core: Core) {
        self.core = core
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHidingKeyboardTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let vc = SignUpViewController(core: core)
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        let vc = ForgotPasswordViewController(core: core)
        navigationController?.pushViewController(vc, animated: false)
    }
}
