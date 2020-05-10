//
//  ConsoleViewController.swift
//  Subtuner
//
//  Created by Untitled on 5/9/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import UIKit

class ConsoleViewController: BaseViewController {
    
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
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        [logOutAction, cancelAction].forEach { optionMenu.addAction($0) }
        self.parent?.present(optionMenu, animated: true, completion: nil)
    }
}
