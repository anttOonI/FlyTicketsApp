//
//  MapBuilder.swift
//  FlyTickets
//
//  Created by AntonSobolev on 28.07.2021.
//

import UIKit

protocol MapBuiderProtocol {
	static func createMapScreen() -> UIViewController
}

class MapBuilder: MapBuiderProtocol {
	static func createMapScreen() -> UIViewController {
		let view = MapVC()
		let presenter = MapPresenter()
		view.presenter = presenter
		
		return view
	}
	
	
}
