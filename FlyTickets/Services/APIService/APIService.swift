//
//  APIService.swift
//  FlyTickets
//
//  Created by AntonSobolev on 16.07.2021.
//

import Foundation

final class APIService {
	
	// MARK: - Public Properties
	
	static let shared = APIService()

	// MARK: - Initializers
	private init() {
	}
	
	// MARK: - Private Methods
	
	private func executeRequestForURL<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
		guard let url = URL(string: urlString) else { return }
		let session = URLSession.shared
		
		session.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//				completion(.failure(error))
				return
			}
			
			guard let data = data else {
//				completion(.failure(error))
				return
			}
			print(data)
			do {
				let decoder = JSONDecoder()
				let result = try decoder.decode(T.self, from: data)
				completion(.success(result))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}.resume()
	}
	
	private func getIPAddressWithCompletion(completion: @escaping (String) -> ()) {
		executeRequestForURL(urlString: APIConstants.apiUrlForIPAdress) { (response: Result<IPAdress, Error>) in
			switch response {
			case .success(let result):
				print(result)
				completion(result.ip)
			case .failure(let error):
				print("in failure - \(error.localizedDescription)")
			}
		}
	}
	
	// MARK: - Public Methods
	
	func getCityForCurrentIP(completion: @escaping (IPCity) -> ()) {
		self.getIPAddressWithCompletion { (ipAdress) in
			let fullUrl = APIConstants.apiUrlForCityFromIP + ipAdress
			self.executeRequestForURL(urlString: fullUrl) { (result: Result<IPCity, Error>) in
				switch result {
				case .success(let city):
					completion(city)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}
