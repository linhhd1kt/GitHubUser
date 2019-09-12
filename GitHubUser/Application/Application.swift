import Foundation
import Domain
import NetworkPlatform

final class Application {
	static let shared = Application()
	
	private let networkUseCaseProvider: Domain.UseCaseProvider
	
	private init() {
		self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
	}
	
	func configureMainInterface(in window: UIWindow) {
		UINavigationBar.appearance().tintColor = .darkGray
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		let networkNavigationController = UINavigationController()
		networkNavigationController.tabBarItem = UITabBarItem(title: "Network",
															  image: UIImage(named: "Toolbox"),
															  selectedImage: nil)
		let networkNavigator = DefaultUsersNavigator(services: networkUseCaseProvider,
													 navigationController: networkNavigationController,
													 storyBoard: storyboard)
		
		window.rootViewController = networkNavigationController
		
		networkNavigator.toUsers()
	}
}
