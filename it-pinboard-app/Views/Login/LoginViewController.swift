//
//  LoginViewController.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var loginButton: GIDSignInButton!
    
    private enum Constants {
        static let kCFBundleDisplayName = "CFBundleName"
        static let alternativeTitle = NSLocalizedString("App Name", comment: "")
    }
    
    // MARK: - Properties
    
    var appName: String? {
        return Bundle.main.object(forInfoDictionaryKey: Constants.kCFBundleDisplayName) as? String
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginFlow()
        configureView()
    }
    
    private func configureLoginFlow() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    private func configureView() {
        navigationItem.hidesBackButton = true
        navigationItem.title = appName ?? Constants.alternativeTitle
    }
}


extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to log into Google: ", error.localizedDescription)
            return
        }
        
        guard let authInfo = user.authentication else { return }
        let creds = GoogleAuthProvider
                    .credential(withIDToken: authInfo.idToken,
                                accessToken: authInfo.accessToken)
        
        LoadingPresenter(with: self).present()
        
        Auth.auth().signIn(with: creds) { [weak self] (result, error) in
            guard let self = self else { return }
            
            if let error = error {
                LoadingPresenter(with: self).dismiss()
                print("Failed to log into Firebase: ", error.localizedDescription)
                return
            }
       
            guard let menuVC = MenuViewController.fromStoryboard() else { return }
            LoadingPresenter(with: self).dismiss {
                self.navigationController?.pushViewController(menuVC, animated: false)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
       // Perform any operations when the user disconnects from app here.
    }
}

// MARK: - GIDSignInUIDelegate

extension LoginViewController: GIDSignInUIDelegate {}
