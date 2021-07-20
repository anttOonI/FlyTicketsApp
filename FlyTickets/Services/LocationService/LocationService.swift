//
//  LocationService.swift
//  FlyTickets
//
//  Created by AntonSobolev on 16.07.2021.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
	
	// MARK: - Private Properties
	
	private let locationManager = CLLocationManager()
	private var currentLocation = CLLocation()
	
	// MARK: - Initializers
	
	override init() {
		 super.init()
		 locationManager.delegate = self
		 locationManager.requestAlwaysAuthorization()
	 }

	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		let status = manager.authorizationStatus
		
		if(status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse) {
			locationManager.startUpdatingLocation()
		} else if status != CLAuthorizationStatus.notDetermined {
			print("Cannot find current location!")
		}
	}
	
	 func locationManager(_ manager: CLLocationManager,
						  didUpdateLocations locations: [CLLocation]) {
		
		currentLocation = locations.first
		
		locationManager.stopUpdatingLocation()
		
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationServiceDidUpdateCurrentLocation"), object: currentLocation)
	 }
	
	
	
	
	
	
	
	
	
	
	
	
}

