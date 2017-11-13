//
//  BaseWireframe.swift
//  Droppit
//
//  Created by Amador Navarro on 18/10/2017.
//  Copyright © 2017 Amador Navarro. All rights reserved.
//

import UIKit

class BaseWireframe {
    
    enum DisplayMode { case present, push, root }
    
    weak var presenterViewController: UIViewController!
    
    //MARK: - Private Func
    private func displayScreenMode(displayMode: DisplayMode, viewController: UIViewController) {
        switch displayMode {
        case .present:
            presenterViewController.present(viewController, animated: true, completion: nil)
        case .push:
            if let navigationController = presenterViewController.navigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        case .root:
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController = viewController
                window.backgroundColor = .white
                window.makeKeyAndVisible()
            }
        }
    }
    
    
    //MARK: - Navigation Func
    // Uncomment when implement side menu
    
//    func displayLogin(displayMode: DisplayMode = .push) {
//        displayScreenMode(displayMode: displayMode, viewController: LoginViewController())
//    }
//
//    func displayRegister() {
//        displayScreenMode(displayMode: .push, viewController: RegisterViewController())
//    }

//    func displayRecoveryPasswordConfirm(withEmail email: String) {
//        let viewController = RecoveryPasswordConfirmViewController()
//        viewController.viewModel.setup(withEmail: email)
//        displayScreenMode(displayMode: .push, viewController: viewController)
//    }
    
}
