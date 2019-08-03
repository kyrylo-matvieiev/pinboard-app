//
//  AddPointAlertView.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 8/1/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

protocol AddPointAlertViewDelegate: class {
    func saveNewPoint(with name: String)
}

class AddPointAlertView: UIView, XibLoadable {
    
    private enum Constants {
        static let kButtonColor = #colorLiteral(red: 0, green: 0.479465425, blue: 1, alpha: 1)
        static let kCornerRadius: CGFloat  = 6
        static let kBorderWidth: CGFloat = 2
        static let kBgColor = #colorLiteral(red: 0.2192138871, green: 0.2359115126, blue: 0.259275401, alpha: 0.7802321743)
        
        enum Localized {
            static let kOkButton = NSLocalizedString("Save", comment: "")
            static let kCancelButton = NSLocalizedString("Cancel", comment: "")
            static let errorMsg = NSLocalizedString("Error: point name field empty", comment: "")
        }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private var actionButtons: [UIButton]!
    
    // MARK: - Properties
    
    private var allButonsTitle: [String] {
        return [Constants.Localized.kCancelButton,
                Constants.Localized.kOkButton]
    }
    
    private var isInputFieldValid: Bool {
        guard let text = inputTextField.text else { return false }
        let isEmpty = text.trimmingCharacters(in: .whitespaces).isEmpty
        return !isEmpty
    }
    
    weak var delegate: AddPointAlertViewDelegate?
    
    // MARK: - Configure
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        containerView.layoutIfNeeded()
    }
    
    private func configureView() {
        backgroundColor = Constants.kBgColor
        
        errorLabel.text = ""
        errorLabel.textColor = .red
        
        inputTextField.becomeFirstResponder()
        containerView.layer.cornerRadius = Constants.kCornerRadius
        containerView.layer.masksToBounds = true
        
        for (idx, button)  in actionButtons.enumerated() {
            button.backgroundColor = Constants.kButtonColor
            button.setTitle(allButonsTitle[idx], for: .normal)
            button.tintColor = .white
        }
        
        
        actionButtons[0].addTarget(self, action: #selector(cancelButttonAction),
                                   for: .touchUpInside)
        actionButtons[1].addTarget(self, action: #selector(saveButtonAction),
                                   for: .touchUpInside)
        inputTextField.addTarget(self, action: #selector(textFieldEditingDidChange),
                                 for: .editingChanged)
    }
    
    // MARK: - Actions
    
    @objc
    private func textFieldEditingDidChange() {
        if isInputFieldValid {
            errorLabel.text = ""
        }
    }
    
    @objc
    private func saveButtonAction() {
        guard isInputFieldValid else { errorLabel.text = Constants.Localized.errorMsg; return }
        delegate?.saveNewPoint(with: inputTextField.text!)
    }
    
    @objc
    private func cancelButttonAction() {
        removeFromSuperview()
    }
}
