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
    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        parent?.title = MenuItem.profile.title
    }
    
    @objc
    private func logOutAction() {
        GIDSignIn.sharedInstance().signOut()
    }
}
