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
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    
    private var viewModel: PointsListViewModelType = PointsListViewModel()
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        callbacksConfigure()
        
        refreshData()
    }

    private func configureView() {
        parent?.title = MenuItem.pointsList.title
        tableView.backgroundColor = #colorLiteral(red: 0.9629039313, green: 0.9629039313, blue: 0.9629039313, alpha: 1)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: PointCell.storyboardReuseId, bundle: nil),
                           forCellReuseIdentifier: PointCell.storyboardReuseId)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    private func callbacksConfigure() {
        viewModel.pointsListCallback = { [weak self] in
            self?.configureEmptyView()
        }
        
        viewModel.refreshingStateCallback = { [weak self] state in
            state == .start
                ? self?.tableView.beginRefreshing()
                : self?.tableView.endRefreshing()
        }
    }
    
    @objc
    private func refreshData() {
        viewModel.load()
    }
}

// MARK: - UITableViewDataSource

extension PointsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pointsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointCell.storyboardReuseId, for: indexPath)
        if let pointCell = cell as? PointCell {
            pointCell.delegate = self
            pointCell.configureWith(viewData: viewModel.pointsList[indexPath.row])
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

// MARK: - Helpful Methods

extension PointsListViewController {
    private func configureEmptyView() {
        let emptyView = EmptyView.fromXib()
        if viewModel.pointsList.isEmpty {
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
        tableView.reloadData()
    }
}
