//
//  SceneDelegate.swift
//  FlyTickets
//
//  Created by AntonSobolev on 30.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = createTabbar()
		window?.makeKeyAndVisible()
		
	}

	func createSearchNC() -> UINavigationController {
		let searchVC = FindTicketsBuilder.createSearchScreen()
		searchVC.title = "Find!"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		
		return UINavigationController(rootViewController: searchVC)
	}
	
	func createMapVC() -> UIViewController {
		let mapVC = MapVC()
		mapVC.tabBarItem = UITabBarItem(title: "Price map", image: UIImage(named: "map"), tag: 1)
		
		return mapVC
	}
	
	func createFavoritesVC() -> UIViewController {
		let favoritesVC = FavoritesVC()
		favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
		
		return favoritesVC
	}
	
	func createTabbar() -> UITabBarController {
		let tabbar = UITabBarController()
		UITabBar.appearance().tintColor = UIColor.lightBlue
		tabbar.viewControllers = [createSearchNC(), createMapVC(), createFavoritesVC()]
		
		return tabbar
	}
}

