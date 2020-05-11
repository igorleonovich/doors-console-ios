//
//  RootViewController.swift
//  Subtuner
//
//  Created by Untitled on 5/9/20.
//  Copyright © 2020 Subtuner. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController {
    
    let centerView = UIView()
    
    let core: Core
    
    var loadingViewController: UIViewController?
    var mainNavigationController: UINavigationController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(core: Core) {
        self.core = core
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showLogInViewController()
    }
    
    private func setupUI() {
        setupCenterView()
        showLoadingViewController()
    }
    
    private func setupCenterView() {
        centerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerView)
        centerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        centerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        centerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        centerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func showLoadingViewController() {
        let loadingViewController = LoadingViewController()
        addChild(loadingViewController)
        
        loadingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(loadingViewController.view)
        
        loadingViewController.view.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        loadingViewController.view.leadingAnchor.constraint(equalTo: centerView.leadingAnchor).isActive = true
        loadingViewController.view.trailingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        loadingViewController.view.bottomAnchor.constraint(equalTo: centerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        loadingViewController.didMove(toParent: self)
        self.loadingViewController = loadingViewController
    }
    
    private func showLogInViewController() {
        let logInViewController = LogInViewController(core: core)
        let mainNavigationController = UINavigationController(rootViewController: logInViewController)
        addChild(mainNavigationController)
        mainNavigationController.view.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(mainNavigationController.view)
        mainNavigationController.view.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        mainNavigationController.view.leadingAnchor.constraint(equalTo: centerView.leadingAnchor).isActive = true
        mainNavigationController.view.trailingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        mainNavigationController.view.bottomAnchor.constraint(equalTo: centerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainNavigationController.didMove(toParent: self)
        self.mainNavigationController = mainNavigationController
        
        guard let loadingViewController = loadingViewController else { return }
        loadingViewController.willMove(toParent: nil)
        loadingViewController.view.removeFromSuperview()
        loadingViewController.removeFromParent()
        self.loadingViewController = nil
    }
    
    private func showConsoleViewController() {
        
    }
}
