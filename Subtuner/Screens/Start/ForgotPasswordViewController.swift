//
//  ForgotPasswordViewController.swift
//  Subtuner
//
//  Created by Untitled on 5/10/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
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
    
    @IBAction func recoverButtonTapped(_ sender: Any) {
        
    }
}
