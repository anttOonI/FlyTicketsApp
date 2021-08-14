//
//  TicketBuilder.swift
//  FlyTickets
//
//  Created by AntonSobolev on 31.07.2021.
//

import UIKit

protocol TicketBuilderProtocol: class {
	static func createTicketScreen(with tickets: [Ticket]) -> UIViewController
}

class TicketBuilder: TicketBuilderProtocol {
	static func createTicketScreen(with tickets: [Ticket]) -> UIViewController {
		let view = TicketVC()
		let presenter = TicketsPresenter(view: view, tickets: tickets)
		view.presenter = presenter
		return view
	}
	
	
}
