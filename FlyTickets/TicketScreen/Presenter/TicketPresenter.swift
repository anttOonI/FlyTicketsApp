//
//  TicketPresenter.swift
//  FlyTickets
//
//  Created by AntonSobolev on 31.07.2021.
//

import Foundation

protocol TicketsViewProtocol: class {
	var tickets: [Ticket] { get set }
}

protocol TicketsViewPresenterProtocol: class {
	init(view:TicketsViewProtocol, tickets: [Ticket])
	func viewRequesTickets()
}

class TicketsPresenter: TicketsViewPresenterProtocol {
	
	// MARK: - TicketsViewPresenterProtocol
	
	weak var view: TicketsViewProtocol?
	private var tickets: [Ticket]
	required init(view: TicketsViewProtocol, tickets: [Ticket]) {
		self.view = view
		self.tickets = tickets
	}
	
	func viewRequesTickets() {
		view?.tickets = tickets
	}
	

	
	

}

