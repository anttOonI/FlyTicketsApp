//
//  FavoritesVC.swift
//  FlyTickets
//
//  Created by AntonSobolev on 09.07.2021.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	
	// MARK: - Private Properties
	
	private var tableView = UITableView()
	
	// MARK: - Private Methods
	
	private func configureTableView() {
		view.addSubview(tableView)
		setTableViewDelegates()
		tableView.register(FavoriteViewCell.self, forCellReuseIdentifier: FavoriteViewCell.identifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
		])
	}

	private func setTableViewDelegates() {
		tableView.delegate = self
		tableView.dataSource = self
	}
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	
}
