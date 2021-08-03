//
//  PlacesVC.swift
//  FlyTickets
//
//  Created by AntonSobolev on 02.07.2021.
//

import UIKit

class PlacesVC: UIViewController {
	
	// MARK: - Public Properties
	var str = ""
	var presenter: PlacesViewPresenterProtocol?
	let placeType: PlaceType
	var currentSource = [Codable]()
	
	
	// MARK: - Private Properties
	
	private var tableView = UITableView()
	private var segmentedControl = UISegmentedControl()
	private var searchController = UISearchController()
	private var filteredSourceArray = [Codable]()
	private var isFiltering: Bool {
		return searchController.isActive && (filteredSourceArray.count > 0)
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationItem.largeTitleDisplayMode = .always
		
		configureTableView()
		configureSegmentControl()
		configureSearchController()
		
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
	
	private func configureSearchController() {
		searchController.searchResultsUpdater = self
		searchController.delegate = self
		searchController.searchBar.delegate = self
		searchController.searchBar.autocapitalizationType = .none
		searchController.searchBar.searchTextField.placeholder = "Search place"
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.hidesNavigationBarDuringPresentation = true
		
		searchController.searchBar.returnKeyType = .done
		
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
	
	private func changeSource() {
		presenter?.viewDidSelectSourceWith(selectedIndex: segmentedControl.selectedSegmentIndex)
	}
	
	// MARK: - Public Methods
	
	@objc func placesDidChange(_ segmentedControl: UISegmentedControl) {
		changeSource()
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PlacesVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering {
			return filteredSourceArray.count
		}
		return currentSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PlacesViewCell.identifier) as! PlacesViewCell
		
		if segmentedControl.selectedSegmentIndex == 0 {
			let city: City = self.isFiltering ? filteredSourceArray[indexPath.row] as! City : currentSource[indexPath.row] as! City
//			guard let city: City = currentSource[indexPath.row] as? City else { return cell }
			cell.nameLabel.text = city.name
			cell.codeLabel.text = city.code
		} else if segmentedControl.selectedSegmentIndex == 1 {
			let airport: Airport = self.isFiltering ? filteredSourceArray[indexPath.row] as! Airport : currentSource[indexPath.row] as! Airport
//			guard let airport: Airport = currentSource[indexPath.row] as? Airport else { return cell }
			cell.nameLabel.text = airport.name
			cell.codeLabel.text = airport.code
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if isFiltering {
			presenter?.viewDidSelectPlace(withPlace: filteredSourceArray[indexPath.row], withType: placeType)
			searchController.isActive = false
		} else {
			presenter?.viewDidSelectPlace(withPlace: currentSource[indexPath.row], withType: placeType)
		}
	}
}

// MARK: - PlacesViewProtocol

extension PlacesVC: PlacesViewProtocol {
	
	func reloadTable() {
		self.tableView.reloadData()
	}
}

// MARK: - UISearchResultsUpdating

extension PlacesVC: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
	
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
		
		filteredSourceArray = currentSource.filter() {
			if let sourceType = $0 as? City {
				return sourceType.name.lowercased().contains(filter.lowercased())
			} else if let sourceType = $0 as? Airport {
				return sourceType.name.lowercased().contains(filter.lowercased())
			} else {
				return false
			}
		}
		reloadTable()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		filteredSourceArray = currentSource
		reloadTable()
	}
}
