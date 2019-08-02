//
//  ProfileViewController.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    private enum Constants {
        static let kBtnBgColor = #colorLiteral(red: 0.3054490702, green: 0.5764283372, blue: 0.8675153881, alpha: 1)
        static let kBtnTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let kBtnCornerRadius: CGFloat = 5
        
        static let buttonTitle = NSLocalizedString("Log Out", comment: "")
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var logOutButton: UIButton!
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        parent?.title = MenuItem.profile.title
        view.backgroundColor = #colorLiteral(red: 0.9629039313, green: 0.9629039313, blue: 0.9629039313, alpha: 1)
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        logOutButton.layer.cornerRadius = Constants.kBtnCornerRadius
        logOutButton.backgroundColor = Constants.kBtnBgColor
        logOutButton.tintColor = Constants.kBtnTintColor
        logOutButton.setTitle(Constants.buttonTitle, for: .normal)
    }
    
    // MARK: Actions
    
    @objc
    private func logOutAction() {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.popToRootViewController(animated: true)
    }
}
