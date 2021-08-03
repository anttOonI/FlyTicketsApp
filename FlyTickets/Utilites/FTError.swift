//
//  FTError.swift
//  FlyTickets
//
//  Created by AntonSobolev on 31.07.2021.
//

import Foundation

enum FTError: String, Error {
	case invalidURL = "This URL created an invalid request. Please try again."
	case unableToComplete = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "Invalid response from the server. Please try again."
	case invalidData = "Check data request"
}
