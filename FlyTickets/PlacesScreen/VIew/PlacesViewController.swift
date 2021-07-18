//
//  PlacesViewController.swift
//  FlyTickets
//
//  Created by AntonSobolev on 02.07.2021.
//

import UIKit

class PlacesViewController: UIViewController {
	
	//testing model - will replace for model from JSON
	var cities = Array(repeating: "Cities", count: 30)
	var citiesCode = Array(repeating: "CIT", count: 30)
	var airports = Array(repeating: "Airports", count: 30)
	var airCode = Array(repeating: "AIR", count: 30)

	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		self.navigationItem.largeTitleDisplayMode = .never
		
		configureTableView()
		configureSegmentControl()
	}
	
	// MARK: - Public Properties
	
	var presenter: PlacesViewPresenterProtocol!

	// MARK: - Private Properties
	
	private var tableView = UITableView()
	
	// MARK: - Private Methods
	
	private func configureTableView() {
		view.addSubview(tableView)
		setTableViewDelegates()
		tableView.register(PlacesViewCell.self, forCellReuseIdentifier: PlacesViewCell.identifier)
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
	
	private func configureSegmentControl() {
		let items: [String] = ["Cities", "Airports"]
		let segmentedControl = UISegmentedControl(items: items)
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.autoresizingMask = .flexibleWidth
		segmentedControl.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
		segmentedControl.addTarget(self, action: #selector(placesDidChange(_:)), for: .valueChanged)
		self.navigationItem.titleView = segmentedControl

	}
	
	// MARK: - Public Methods
	
	@objc func placesDidChange(_ segmentedControl: UISegmentedControl) {
		switch segmentedControl.selectedSegmentIndex {
		case 0:
			print("cities choosed")
		case 1:
			print("airports choosed")
		default:
			print("default")
		}
	}
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cities.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PlacesViewCell.identifier) as! PlacesViewCell
		
		cell.nameLabel.text = cities[indexPath.row]
		cell.codeLabel.text = citiesCode[indexPath.row]
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		didSelectPlace()
	}
}

extension PlacesViewController: PlacesViewProtocol {
	func didSelectPlace() {
		
	}
	
	func reloadTable() {
		
	}
	
	
}
