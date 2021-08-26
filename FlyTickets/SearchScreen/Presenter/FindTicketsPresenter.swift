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
	func showAlert()
}
//output
protocol FindTicketsPresenterProtocol: class {
	init(view: (FindTicketViewProtocol & FindTicketsVC), title: String)
	func viewDidTapFieldWithType(placeType: PlaceType, presenter: FindTicketsPresenterProtocol)
	func viewDidTapSearchButton()
	func requestData()
	func setPlace(withPlace place: Codable, withType placeType: PlaceType)
}

class FindTicketsPresenter: FindTicketsPresenterProtocol {
	
	// MARK: - Private Properties
	private var searchRequest = SearchRequest()
	
	// MARK: - FindTicketsPresenterProtocol
	
	let title: String
	weak var view: (FindTicketViewProtocol & FindTicketsVC)?
	
	required init(view: (FindTicketViewProtocol & FindTicketsVC), title: String) {
		self.view = view
		self.title = title
	}
	
	public func viewDidTapSearchButton() {
		openTicketView()
	}
	
	func viewDidTapFieldWithType(placeType: PlaceType, presenter: FindTicketsPresenterProtocol) {
		openPlaceView(placeType: placeType, presenter: presenter)
	}
	
	func requestData() {
		
		self.view?.showActivityIndicator(show: true)
		
		DataService.shared.loadData()
		APIService.shared.getCityForCurrentIP { [weak self] city in
			guard let self = self else { return }
			
			self.view?.setTitleForField(title: city.name, withType: PlaceType.PlaceTypeDeparture)
			self.view?.showActivityIndicator(show: false)
			self.searchRequest.origin = city.iata
		}
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
		if placeType == PlaceType.PlaceTypeDeparture {
			searchRequest.origin = iata
		} else {
			searchRequest.destination = iata
		}
		view?.setTitleForField(title: title, withType: placeType)
		view?.navigationController?.popViewController(animated: true)
	}
	
	// MARK: - Private Methods
	
	private func openPlaceView(placeType: PlaceType, presenter: FindTicketsPresenterProtocol) {
		let placeVC = PlacesBuilder.createPlacesScreen(withPlaceType: placeType, with: presenter)
		view?.navigationController?.pushViewController(placeVC, animated: true)
	}
	
	private func openTicketView() {
		var tickets = [Ticket]()
		APIService.shared.getTicketsWithRequest(request: searchRequest) { result in
			
			if result.data.isEmpty { self.view?.showAlert() }
			
			let _: [String : [String : Ticket]] = result.data.mapValues { dest in
				let resultDest: [String : Ticket] = dest.mapValues { ticket in
					var mutableTicket = ticket
					mutableTicket.from = self.searchRequest.origin
					mutableTicket.to = self.searchRequest.destination
					tickets.append(mutableTicket)
					return mutableTicket
				}
				let ticketsVC = TicketBuilder.createTicketScreen(with: tickets)
				self.view?.navigationController?.pushViewController(ticketsVC, animated: true)
				return resultDest
			}
		}
	}
}
