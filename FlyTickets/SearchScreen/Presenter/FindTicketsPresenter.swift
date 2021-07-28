//
//  FindTicketsPresenter.swift
//  FlyTickets
//
//  Created by AntonSobolev on 12.07.2021.
//

import Foundation
//input
protocol FindTicketViewProtocol: class {
	func setTitleForField(title: String, withType placeType: PlaceType)
	func showActivityIndicator(show: Bool)
}
//output
protocol FindTicketsPresenterProtocol: class {
	init(view: (FindTicketViewProtocol & FindTicketsVC), title: String)
	func viewDidTapFieldWithType(placeType: PlaceType, presenter: FindTicketsPresenterProtocol)
	func viewDidTapSearch()
	func requestData()
	func setPlace(withPlace place: Codable, withType placeType: PlaceType)
}

class FindTicketsPresenter: FindTicketsPresenterProtocol {
	
	
	// MARK: - FindTicketsPresenterProtocol
	
	let title: String
	weak var view: (FindTicketViewProtocol & FindTicketsVC)?
	
	required init(view: (FindTicketViewProtocol & FindTicketsVC), title: String) {
		self.view = view
		self.title = title
	}
	
	public func viewDidTapSearch() {
//		let title = self.title
//		self.view?.setTitleForField(title: title)
	}
	
	func viewDidTapFieldWithType(placeType: PlaceType, presenter: FindTicketsPresenterProtocol) {
		openPlaceView(placeType: placeType, presenter: presenter)
	}

	func requestData() {
		view?.showActivityIndicator(show: true)
		DataService.shared.loadData()
	}
	func setPlace(withPlace place: Codable, withType placeType: PlaceType) {
		var title = ""
		var iata = ""
		
		if place is City {
			let city: City = place as! City
			title = city.name
			iata = city.code
		} else if place is Airport {
			let airport: Airport = place as! Airport
			title = airport.name
			iata = airport.cityCode
		}
		view?.setTitleForField(title: title, withType: placeType)
		view?.navigationController?.popViewController(animated: true)
	}
	
	// MARK: - Private Methods
	
	private func openPlaceView(placeType: PlaceType, presenter: FindTicketsPresenterProtocol) {
		let placeVC = PlacesBuilder.createPlacesScreen(withPlaceType: placeType, with: presenter)
		view?.navigationController?.pushViewController(placeVC, animated: true)
	}
	
	
}
