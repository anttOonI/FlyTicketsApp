//
//  DataService.swift
//  FlyTickets
//
//  Created by AntonSobolev on 27.07.2021.
//

import Foundation

final class DataService {
	
	// MARK: - Private Properties
	
	private let typeOfFile = "json"
	private let cityResource = "cities"
	private let countryResource = "countries"
	private let airportResource = "airports"
	
	private let parseGroup = DispatchGroup()
	
	// MARK: - Public Properties
	
	static let shared = DataService()
	
	var countries = [Country]()
	var cities = [City]()
	var airports = [Airport]()
	
	// MARK: - Initializers
	
	private init() {
	}
	
	// MARK: - Public Methods
	
	func loadData() {
		self.getSource(forResource: self.cityResource, ofType: self.typeOfFile, withType: .DataSourceTypeCity)
		self.getSource(forResource: self.countryResource, ofType: self.typeOfFile, withType: .DataSourceTypeCountry)
		self.getSource(forResource: self.airportResource, ofType: self.typeOfFile, withType: .DataSourceTypeAirport)
		parseGroup.wait()
	}
	
	// MARK: - Private Methods
	
	private func getSource(forResource resource: String, ofType type: String, withType sourceType: DataSourceType) {
		DispatchQueue.global().async(group: parseGroup) {
			guard let path = Bundle.main.path(forResource: resource, ofType: type) else { return }
			let url = URL(fileURLWithPath: path)
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				switch sourceType {
				case .DataSourceTypeCountry:
					self.countries = try decoder.decode([Country].self, from: data)
				case .DataSourceTypeCity:
					self.cities = try decoder.decode([City].self, from: data)
				case .DataSourceTypeAirport:
					self.airports = try decoder.decode([Airport].self, from: data)
				}
			} catch {
				print("error \(error)")
			}
		}
	}
	
}
