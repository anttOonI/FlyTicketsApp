//
//  PlacesBuilder.swift
//  FlyTickets
//
//  Created by AntonSobolev on 15.07.2021.
//

import UIKit

protocol Builder: class {
	static func createPlacesScreen(withPlaceType placeType: PlaceType, with mainPresenter: FindTicketsPresenterProtocol) -> UIViewController
}

class PlacesBuilder: Builder {
	static func createPlacesScreen(withPlaceType placeType: PlaceType, with findPresenter: FindTicketsPresenterProtocol) -> UIViewController {
		let view = PlacesVC(placeType: placeType)
		let presenter = PlacesPresenter(view: view, findPresenter: findPresenter)
		view.presenter = presenter
		
		return view
	}

}
