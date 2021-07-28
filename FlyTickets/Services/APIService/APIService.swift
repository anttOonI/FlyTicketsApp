//
//  APIService.swift
//  FlyTickets
//
//  Created by AntonSobolev on 16.07.2021.
//

import Foundation

final class APIService {
	
	// MARK: - Constants
	// TODO: Перенести в структуру
	
	let apiToken = "9cfb220fbf225dc196d63ea213925fc8"
	let apiUrlForIPAdress = "https://api.ipify.org/?format=json"
	let apiUrlForCheap = "https://api.travelpayouts.com/v1/prices/cheap"
	let apiUrlForCityFromIP = "https://www.travelpayouts.com/whereami?ip="
	let apiUrlForMapPrice = "https://map.aviasales.ru/prices.json?origin_iata="
	
	// MARK: - Public Properties
	
	static let shared = APIService()

	// MARK: - Initializers
	private init() {
	}
	
	// MARK: - Private Methods
	
	private func executeRequestForURL(urlString: String, completion: @escaping () -> ()) {
		let url = URL(string: urlString)
		let session = URLSession.shared
	}
	
	
}
