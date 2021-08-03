//
//  TicketBuilder.swift
//  FlyTickets
//
//  Created by AntonSobolev on 31.07.2021.
//

import UIKit

protocol TicketBuilderProtocol: class {
	static func createTicketScreen() -> UIViewController
}

class TicketBuilder: TicketBuilderProtocol {
	static func createTicketScreen() -> UIViewController {
		
		return UIViewController()
	}
	
	
}
