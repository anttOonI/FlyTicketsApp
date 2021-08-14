//
//  UIHelper.swift
//  FlyTickets
//
//  Created by AntonSobolev on 12.08.2021.
//

import UIKit

struct UIHelper {
	
	static func createOneColumnFlowLaout(in view: UIView) -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 20
		let availibleWidth = width - (padding * 2)
		let itemWidth = availibleWidth
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth / 3)
		flowLayout.scrollDirection = .vertical
		
		return flowLayout
	}
}
