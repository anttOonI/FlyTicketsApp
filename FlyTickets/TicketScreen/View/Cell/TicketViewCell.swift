//
//  TicketViewCell.swift
//  FlyTickets
//
//  Created by AntonSobolev on 10.08.2021.
//

import UIKit

class TicketViewCell: UICollectionViewCell {
	
	static let identifier = "TicketViewCell"
	
	// MARK: - Private Properties
	private let placeholderImage = UIImage(named: "airplane-placeholder")

	// MARK: - Public Properties

	var priceLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.black
		label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
		label.textAlignment = .left
		return label
	}()
	
	var placesLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.gray
		label.font = UIFont.systemFont(ofSize: 15, weight: .light)
		label.textAlignment = .left
		return label
	}()
	
	var dateLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.black
		label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		label.textAlignment = .left
		return label
	}()
	
	var airlineLogo: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private Methods
	
	private func configureLayout() {
		contentView.backgroundColor = .white
		contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 10).cgPath
		contentView.layer.shadowColor = UIColor.black.cgColor
		contentView.layer.shadowOffset = .zero
		contentView.layer.shadowRadius = 1.0
		contentView.layer.shadowOpacity = 0.5
		contentView.layer.masksToBounds = false
		
		contentView.layer.cornerRadius = 10
		
		priceLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(priceLabel)
		
		placesLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(placesLabel)
		
		dateLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(dateLabel)
		
		airlineLogo.translatesAutoresizingMaskIntoConstraints = false
		airlineLogo.image = placeholderImage
		self.contentView.addSubview(airlineLogo)
		
		NSLayoutConstraint.activate([
			priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			
			placesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			placesLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
			
			dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			dateLabel.topAnchor.constraint(equalTo: placesLabel.bottomAnchor, constant: 10),
			
			airlineLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			airlineLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			airlineLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			airlineLogo.widthAnchor.constraint(equalTo: airlineLogo.heightAnchor),
		])

		
	}

	
}
