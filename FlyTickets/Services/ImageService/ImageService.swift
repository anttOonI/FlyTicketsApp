//
//  ImageService.swift
//  FlyTickets
//
//  Created by AntonSobolev on 13.08.2021.
//

import UIKit

class ImageService {
	
	// MARK: - Public Properties
	
	static let shared = ImageService()
	let imageCache = NSCache<NSString, UIImage>()
	
	// MARK: - Private Properties
	
	private let baseUrl = "https://pics.avs.io/200/200/"
	
	// MARK: - Initializers
	private init() {
	}
	
	// MARK: - Public Methods
	
	func getImageForAirline(iata: String, completion: @escaping (UIImage) -> ()) {
		let urlString = baseUrl + "\(iata).png"
		
		let cachKey = NSString(string: urlString)
		if let image = imageCache.object(forKey: cachKey) {
			completion(image)
			return
		}
		
		guard let url = URL(string: urlString) else { return }
		
		let session = URLSession.shared
		
		session.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self else { return }
			if error != nil { return }
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
			guard let data = data else { return }
			
			guard let image = UIImage(data: data) else { return }
			self.imageCache.setObject(image, forKey: cachKey)
			DispatchQueue.main.async {
				completion(image)
			}
		}.resume()
		
	}
}
