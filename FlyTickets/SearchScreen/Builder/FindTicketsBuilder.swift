//
//  FindTicketsBuilder.swift
//  FlyTickets
//
//  Created by AntonSobolev on 12.07.2021.
//

import UIKit

protocol FindTicketsBuilderProtocol {
	static func createSearchScreen() -> UIViewController
}

class FindTicketsBuilder: FindTicketsBuilderProtocol {
	static func createSearchScreen() -> UIViewController {
		let title = "Я из билдера"
		let view = FindTicketsVC()
		let presenter = FindTicketsPresenter(view: view, title: title)
		view.presenter = presenter
		
		return view
	}
	

}
