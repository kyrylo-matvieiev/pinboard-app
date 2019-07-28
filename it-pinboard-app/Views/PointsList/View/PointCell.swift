//
//  PointCell.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

protocol PointCellDelegate: class {
   func deleteCell()
}

class PointCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    
    // MARK: Properties
    
    private lazy var longTapGesture = {
        return UILongPressGestureRecognizer(target: self, action: #selector(longTapGestureAction))
    }()
    
    weak var delegate: PointCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    // MARK: - Configure
    
    func configureWith(viewData: PointCellViewData) {
        nameLabel.text = viewData.pointName
        latitudeLabel.text = viewData.latitude
        longitudeLabel.text = viewData.longitude
    }
    
    private func configureView() {
        accessoryType = .disclosureIndicator
        addGestureRecognizer(longTapGesture)
    }
    
    // MARK: - Actions
    
    @objc
    private func longTapGestureAction() {
        guard longTapGesture.state == .began else { return }
        delegate?.deleteCell()
    }
}

// MARK: - Helpful UITableViewCell extension

extension UITableViewCell {
    class var storyboardReuseId: String { return "\(self)" }
}
