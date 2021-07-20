//
//  FindTicketsPresenter.swift
//  FlyTickets
//
//  Created by AntonSobolev on 12.07.2021.
//

import Foundation
//input
protocol FindTicketViewProtocol: class {
	func setTitleForField(title: String)
	func showActivityIndicator(show: Bool)
}
//output
protocol FindTicketsPresenterProtocol: class {
	init(view: (FindTicketViewProtocol & FindTicketsVC), title: String)
	func viewDidTapFieldWithType(placeType: PlaceType)
	func viewDidTapSearch()
	func requestData()
	
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
		let title = self.title
		self.view?.setTitleForField(title: title)
	}
	
	func viewDidTapFieldWithType(placeType: PlaceType) {
		openPlaceView(placeType: placeType)
	}

	
	
	func requestData() {
		view?.showActivityIndicator(show: true)
	}
	
	// MARK: - Private Methods
	private func openPlaceView(placeType: PlaceType) {
		let placeVC = PlacesBuilder.createPlacesScreen(with: placeType)
		view?.navigationController?.pushViewController(placeVC, animated: true)
	}
	
	
}
