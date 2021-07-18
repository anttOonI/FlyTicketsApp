//
//  PlacesPresenter.swift
//  FlyTickets
//
//  Created by AntonSobolev on 15.07.2021.
//

import Foundation

protocol PlacesViewProtocol: class {
	func reloadTable()
	func didSelectPlace()
}

protocol PlacesViewPresenterProtocol: class {
	init (view: PlacesViewProtocol, with placeType: PlaceType)
	func didSelectPlace()
}

class PlacesPresenter: PlacesViewPresenterProtocol {

	weak var view: PlacesViewProtocol?
	var searchPresenter: FindTicketsPresenterProtocol!
	let placeType: PlaceType
	
	required init(view: PlacesViewProtocol, with placeType: PlaceType) {
		self.view = view
		self.placeType = placeType
	}
	
	func didSelectPlace() {
		self.view?.didSelectPlace()
	}
	
}
