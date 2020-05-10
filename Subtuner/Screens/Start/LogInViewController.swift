//
//  LoginViewController.swift
//  Subtuner
//
//  Created by Untitled on 5/9/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import UIKit

class LogInViewController: BaseViewController {
    
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
        let vc = SignUpViewController(isModal: false)
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        let vc = ForgotPasswordViewController(isModal: false)
        navigationController?.pushViewController(vc, animated: false)
    }
}
