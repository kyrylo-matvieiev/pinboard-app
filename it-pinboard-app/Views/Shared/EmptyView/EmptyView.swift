//
//  EmptyView.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

final class EmptyView: UIView {
    private enum LoalizedMessages {
        static let emptyList = NSLocalizedString("No point yet", comment: "")
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private  weak var errorMessageLabel: UILabel!
    
    // MARK: - View
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setError(message: LoalizedMessages.emptyList)
    }
    
    // MARK: - Message setter
    
    func setError(message: String) {
        errorMessageLabel.text = message
    }
}
