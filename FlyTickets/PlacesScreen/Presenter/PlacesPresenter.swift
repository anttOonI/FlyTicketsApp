//
//  PlacesPresenter.swift
//  FlyTickets
//
//  Created by AntonSobolev on 15.07.2021.
//

import Foundation

protocol PlacesViewProtocol: class {
	var currentSource: [Codable] { get set }
	func reloadTable()
}

protocol PlacesViewPresenterProtocol: class {
	init (view: PlacesViewProtocol, findPresenter: FindTicketsPresenterProtocol)
	func viewDidSelectPlace(withPlace place: Codable, withType placeType: PlaceType)
	func viewDidSelectSourceWith(selectedIndex: Int)
}

class PlacesPresenter: PlacesViewPresenterProtocol {
	
	// MARK: - PlacesViewPresenterProtocol

	weak var view: PlacesViewProtocol?
	private let findPresenter: FindTicketsPresenterProtocol
	
	required init(view: PlacesViewProtocol, findPresenter: FindTicketsPresenterProtocol) {
		self.view = view
		self.findPresenter = findPresenter
	}
	
	func viewDidSelectSourceWith(selectedIndex: Int) {
		setDataSourceWithSelectedSegment(selectedIndex: selectedIndex)
	}
	
	func viewDidSelectPlace(withPlace place: Codable, withType placeType: PlaceType) {
		selectPlace(withPlace: place, withType: placeType)
	}
	
	// MARK: - Private Methods
	
	private func setDataSourceWithSelectedSegment(selectedIndex: Int) {
		switch selectedIndex {
		case 0:
			view?.currentSource = DataService.shared.cities
		case 1:
			view?.currentSource = DataService.shared.airports
		default:
			view?.currentSource = []
		}
		view?.reloadTable()
	}
	
	private func selectPlace(withPlace place: Codable, withType placeType: PlaceType) {
		findPresenter.setPlace(withPlace: place, withType: placeType)
	}

}
