//
//  PlacesViewCell.swift
//  FlyTickets
//
//  Created by AntonSobolev on 08.07.2021.
//

import UIKit

class PlacesViewCell: UITableViewCell {

	static let identifier = "CustomQuestionCell"
	
	// MARK: - Public Properties
	
	var nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.black
		label.font = UIFont.systemFont(ofSize: 16)
		label.textAlignment = .left
		return label
	}()
	var codeLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.gray
		label.font = UIFont.systemFont(ofSize: 12)
		label.textAlignment = .left
		return label
	}()
	
	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension PlacesViewCell {
	
	private func configureLayout() {
		contentView.backgroundColor = .white
		
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(nameLabel)
		
		codeLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(codeLabel)
		
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
			nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			
			codeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
			codeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
			codeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
		])
		
	}
}
