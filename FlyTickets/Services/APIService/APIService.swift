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
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
			
			guard let data = data else { return }
			
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
	//	вот такой урл https://api.travelpayouts.com/v1/prices/cheap?origin=LED&destination=DME&token=9cfb220fbf225dc196d63ea213925fc8
	func getTicketsWithRequest(request: SearchRequest, completion: @escaping (TicketsResponse) -> ()) {
		var urlComponents = URLComponents(string: APIConstants.apiUrlForCheap)
		urlComponents?.queryItems = [
			URLQueryItem(name: "origin", value: request.origin),
			URLQueryItem(name: "destination", value: request.destination),
			URLQueryItem(name: "token", value: APIConstants.apiToken),
		]
		let url = urlComponents?.url?.absoluteString
		self.executeRequestForURL(urlString: url!) { (result: Result<TicketsResponse, Error>) in
			switch result {
			case .success(let ticket):
				print(ticket)
			case .failure(let error):
				print(error)
			}
		}
	}
}
