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
	init(view: FindTicketViewProtocol, title: String)
	func findTicket()
	func openPlaceView()
	func requestData()
}

class FindTicketsPresenter: FindTicketsPresenterProtocol {
	
	
	let title: String
	weak var view: FindTicketViewProtocol?
	
	required init(view: FindTicketViewProtocol, title: String) {
		self.view = view
		self.title = title
	}
	
	public func findTicket() {
		let title = self.title
		self.view?.setTitleForField(title: title)
	}
	
	func openPlaceView() {
		
		
	}
	
	func requestData() {
		<#code#>
	}
	
}
