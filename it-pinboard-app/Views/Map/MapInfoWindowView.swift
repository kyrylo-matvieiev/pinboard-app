//
//  MapInfoWindowView.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 8/1/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

class MapInfoWindowView: UIView, XibLoadable {
    private enum Constants {
        static let kCornerRadius: CGFloat  = 4
        static let kBorderWidth: CGFloat = 2
        static let kBorderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        static let kBgColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9419145976)
        static let textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var pointNameLabel: UILabel!
    
    // MARK: Properties
    
    private var pointNameLabaelText: String = "" {
        didSet {
            self.pointNameLabel.text = pointNameLabaelText
        }
    }
    
    // MARK: - View
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        backgroundColor = Constants.kBgColor
        pointNameLabel.textColor = Constants.textColor
        layer.cornerRadius = frame.size.width / 2
        layer.borderWidth = Constants.kBorderWidth
        layer.borderColor = Constants.kBorderColor.cgColor
    }
    
    func configure(with pointName: String?) {
        pointNameLabaelText = pointName ?? "Empty point name"
    }
}
