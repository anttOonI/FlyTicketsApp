//
//  PlacesBuilder.swift
//  FlyTickets
//
//  Created by AntonSobolev on 15.07.2021.
//

import UIKit

protocol Builder: class {
	static func createPlacesScreen(with placeType: PlaceType) -> UIViewController
}

class PlacesBuilder: Builder {
	static func createPlacesScreen(with placeType: PlaceType) -> UIViewController {
		let view = PlacesViewController()
		let placeType = placeType
		let presenter = PlacesPresenter(view: view, with: placeType)
		view.presenter = presenter
		
		return view
	}

}
