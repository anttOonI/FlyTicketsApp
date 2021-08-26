//
//  ViewController.swift
//  FlyTickets
//
//  Created by AntonSobolev on 30.06.2021.
//

import UIKit

class FindTicketsVC: UIViewController {
	
	// MARK: - Public Properties
	
	var presenter: FindTicketsPresenterProtocol!
	var searchRequest: SearchRequest!
	
	// MARK: - Private Properties
	
	private var fromTextField = UITextField()
	private var toTextField = UITextField()
	private var goFindButton = UIButton()
	private var activityIndicator = UIActivityIndicatorView()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundLightBlue
		configureNavigationBar()
		setupLayout()
		
		presenter.requestData()
	}
	
	// MARK: - Private Methods
	
	private func configureNavigationBar() {
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func setupLayout() {
		
		fromTextField.translatesAutoresizingMaskIntoConstraints = false
		fromTextField.textAlignment = .center
		fromTextField.placeholder = "From..."
		fromTextField.font = UIFont.systemFont(ofSize: 15)
		fromTextField.backgroundColor = .white
		fromTextField.layer.cornerRadius = 5
		
		fromTextField.addTarget(self, action: #selector(showListOfPlaces(_:)), for: .touchDown)

		view.addSubview(fromTextField)
		
		toTextField.translatesAutoresizingMaskIntoConstraints = false
		toTextField.textAlignment = .center
		toTextField.placeholder = "To..."
		toTextField.font = UIFont.systemFont(ofSize: 15)
		toTextField.backgroundColor = .white
		toTextField.layer.cornerRadius = 5
		
		toTextField.addTarget(self, action: #selector(showListOfPlaces(_:)), for: .touchDown)

		
		view.addSubview(toTextField)
		
		goFindButton.translatesAutoresizingMaskIntoConstraints = false
		goFindButton.titleLabel?.textAlignment = .center
		goFindButton.setTitle("Find tickets", for: .normal)
		goFindButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		goFindButton.backgroundColor = .darkGray
		goFindButton.layer.cornerRadius = 5
		
		goFindButton.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchDown)
		
		view.addSubview(goFindButton)
		
		activityIndicator.style = .medium
		activityIndicator.color = .gray
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			
			fromTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			fromTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			fromTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
			fromTextField.heightAnchor.constraint(equalToConstant: 50),
			
			toTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			toTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 10),
			toTextField.heightAnchor.constraint(equalToConstant: 50),
			
			goFindButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			goFindButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			goFindButton.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 30),
			goFindButton.heightAnchor.constraint(equalToConstant: 50),
			
			activityIndicator.centerYAnchor.constraint(equalTo: fromTextField.centerYAnchor),
			activityIndicator.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor, constant: -(activityIndicator.bounds.width - 5))
		])
	}

	@objc private func showListOfPlaces(_ textField: UITextField) {
		let placeType = textField.isEqual(fromTextField) ? PlaceType.PlaceTypeDeparture : PlaceType.PlaceTypeArrival
		presenter.viewDidTapFieldWithType(placeType: placeType, presenter: presenter)
	}
	
	@objc private func searchButtonDidTapped() {
		presenter.viewDidTapSearchButton()
	}
}

extension FindTicketsVC: FindTicketViewProtocol {
	
	func showActivityIndicator(show: Bool) {
		show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
	}
	
	func setTitleForField(title: String, withType placeType: PlaceType) {
		switch placeType {
		case .PlaceTypeDeparture:
			fromTextField.text = title
		case .PlaceTypeArrival:
			toTextField.text = title
		}
	}
	
	func showAlert() {
		let alertVC = UIAlertController(title: "Oops", message: "Sorry, we didn't find any tickets for your destination", preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "Close", style: .default))
		self.present(alertVC, animated: true)
	}
}
