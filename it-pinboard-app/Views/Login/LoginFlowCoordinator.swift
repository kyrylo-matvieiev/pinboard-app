//
//  LoginFlowCoordinator.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginFlowCoordinator: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginFlow()
    }
    
    private func loginFlow() {
        guard let loginVC = LoginViewController.fromStoryboard() else { return }
        guard let mainVC = MenuViewController.fromStoryboard() else { return }
        
        GIDSignIn.sharedInstance().hasAuthInKeychain()
            ? navigationController?.pushViewController(mainVC, animated: false)
            : navigationController?.pushViewController(loginVC, animated: false)
    }
}
