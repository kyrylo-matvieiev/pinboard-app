//
//  LoadingPresenter.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

class LoadingPresenter {
    private var presentingViewController: UIViewController
    
    init(with presentingController: UIViewController) {
        self.presentingViewController = presentingController
    }
    
    func present() {
        let viewController = LoadingViewController()
        viewController.modalPresentationStyle = .overFullScreen
        presentingViewController.present(viewController, animated: true)
    }
    
    func dismiss(_ completion: (() -> Void)? = nil) {
        presentingViewController.dismiss(animated: true, completion: completion)
    }
}
