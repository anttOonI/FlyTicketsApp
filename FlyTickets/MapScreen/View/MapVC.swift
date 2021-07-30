//
//  MapVC.swift
//  FlyTickets
//
//  Created by AntonSobolev on 09.07.2021.
//

import UIKit
import MapKit

class MapVC: UIViewController {
	
	// MARK: - Public Properties
	
	var presenter = MapPresenter()
	
	// MARK: - Private Properties
	
	private var mapView = MKMapView()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self
		configureMapView()
	}
	
	// MARK: - Private Methods
	
	private func configureMapView() {
		view.addSubview(mapView)
		mapView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
}

extension MapVC: MKMapViewDelegate {
	
}
