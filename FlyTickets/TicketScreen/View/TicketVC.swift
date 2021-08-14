//
//  TicketVC.swift
//  FlyTickets
//
//  Created by AntonSobolev on 31.07.2021.
//

import UIKit

class TicketVC: UIViewController {
	
	// MARK: - Public Properties
	
	var presenter: TicketsViewPresenterProtocol?
	var tickets = [Ticket]()
	
	// MARK: - Private Properties
	
	private var collectionView: UICollectionView!

	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		self.title = "Tickets"
		presenter?.viewRequesTickets()
	}
	
	
	// MARK: - Private Methods
	
	private func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createOneColumnFlowLaout(in: view))
		view.addSubview(collectionView)
		setCollectionViewDelegates()
		collectionView.register(TicketViewCell.self, forCellWithReuseIdentifier: TicketViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .white
	}
	
	private func setCollectionViewDelegates() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}
}

extension TicketVC: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tickets.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketViewCell.identifier, for: indexPath) as! TicketViewCell
		cell.dateLabel.text = tickets[indexPath.item].departureDate.convertDate()
		// TODO: сюда передать откуда и куда - ИАТА коды
		cell.placesLabel.text  = "\(tickets[indexPath.item].from!) - \(tickets[indexPath.item].to!)"
		cell.priceLabel.text = "\(tickets[indexPath.item].price) руб."
		ImageService.shared.getImageForAirline(iata: tickets[indexPath.item].airline) { image in
			cell.airlineLogo.image = image
		}
		
		return cell
	}
	

}

extension TicketVC: TicketsViewProtocol {

}
