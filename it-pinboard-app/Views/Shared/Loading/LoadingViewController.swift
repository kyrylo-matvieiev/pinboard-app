//
//  LoadingView.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    private lazy var spinner: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .white)
        activityView.startAnimating()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    override func loadView() {
        view = UIView()
        view.layer.opacity = 0.4
        view.backgroundColor = .black
        view.addSubview(spinner)
    }
    
    override func viewWillLayoutSubviews() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
