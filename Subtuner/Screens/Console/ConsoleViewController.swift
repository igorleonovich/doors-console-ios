//
//  ConsoleViewController.swift
//  Subtuner
//
//  Created by Untitled on 5/9/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import UIKit
import MBProgressHUD

class ConsoleViewController: BaseViewController {
    
    let core: Core
    
    init(core: Core) {
        self.core = core
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Menu", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive, handler: { action in
            MBProgressHUD.showAdded(to: self.view, animated: true)
            self.core.authManager.logOut { [weak self] error in
                guard let `self` = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    guard let rootViewController = self.navigationController?.parent as? RootViewController else { return }
                    rootViewController.removeConsoleNavigationController()
                    rootViewController.showAuthNavigationController()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        [logOutAction, cancelAction].forEach { optionMenu.addAction($0) }
        self.parent?.present(optionMenu, animated: true, completion: nil)
    }
}
