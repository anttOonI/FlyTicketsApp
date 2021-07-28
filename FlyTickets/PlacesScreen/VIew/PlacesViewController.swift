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
//
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		self.navigationItem.largeTitleDisplayMode = .always
		
		configureTableView()
		configureSegmentControl()
		
		if placeType == PlaceType.PlaceTypeDeparture {
			self.title = "From..."
		} else {
			self.title = "To..."
		}
		
		changeSource()
	}
	
	// MARK: - Initializers
	init(placeType: PlaceType) {
		self.placeType = placeType
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Properties
	
	var presenter: PlacesViewPresenterProtocol?
	let placeType: PlaceType
	var currentSource = [Codable]()
	
	// MARK: - Private Properties
	
	private var tableView = UITableView()
	private var segmentedControl = UISegmentedControl()
	private var filteredSourceArray = [Any]()
	
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
		segmentedControl.insertSegment(withTitle: items[0], at: 0, animated: true)
		segmentedControl.insertSegment(withTitle: items[1], at: 1, animated: true)
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.autoresizingMask = .flexibleWidth
		segmentedControl.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
		segmentedControl.addTarget(self, action: #selector(placesDidChange(_:)), for: .valueChanged)
		self.navigationItem.titleView = segmentedControl

	}
	
	private func changeSource() {
		presenter?.viewDidSelectSourceWith(selectedIndex: segmentedControl.selectedSegmentIndex)
	}
	
	// MARK: - Public Methods
	
	@objc func placesDidChange(_ segmentedControl: UISegmentedControl) {
		changeSource()
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
		return currentSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PlacesViewCell.identifier) as! PlacesViewCell
		
		if segmentedControl.selectedSegmentIndex == 0 {
			guard let city: City = currentSource[indexPath.row] as? City else { return cell }
			cell.nameLabel.text = city.name
			cell.codeLabel.text = city.code
		} else if segmentedControl.selectedSegmentIndex == 1 {
			guard let airport: Airport = currentSource[indexPath.row] as? Airport else { return cell }
			cell.nameLabel.text = airport.name
			cell.codeLabel.text = airport.code
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.viewDidSelectPlace(withPlace: currentSource[indexPath.row], withType: placeType)
	}
}

extension PlacesViewController: PlacesViewProtocol {
	
	func reloadTable() {
		self.tableView.reloadData()
	}
	
	
}
