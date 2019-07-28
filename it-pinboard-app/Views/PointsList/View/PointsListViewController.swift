//
//  PointsListViewController.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

class PointsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private  weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var viewModel: PointsListViewModelType = PointsListViewModel()
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: PointCell.storyboardReuseId, bundle: nil),
                          forCellReuseIdentifier: PointCell.storyboardReuseId)
    }
}

// MARK: - UITableViewDataSource

extension PointsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointCell.storyboardReuseId, for: indexPath)
        if let pointCell = cell as? PointCell {
            pointCell.delegate = self
            //
            let testData = PointCellViewData(pointName: "Point name", latitude: "latitude", longitude: "longitude")
            //
            pointCell.configureWith(viewData: testData)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PointsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

// MARK: - PointCellDelegate

extension PointsListViewController: PointCellDelegate {
    func deleteCell() {
        print("PointCell delegate")
    }
}
