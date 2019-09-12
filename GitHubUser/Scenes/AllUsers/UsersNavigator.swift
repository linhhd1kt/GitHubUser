import UIKit
import Domain

protocol UsersNavigator {
    func toUser(_ id: String)
}

class DefaultUsersNavigator: UsersNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider

    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toUsers() {
        let vc = storyBoard.instantiateViewController(ofType: UsersViewController.self)
        vc.viewModel = UsersViewModel(useCase: services.makeUsersUseCase(),
                                      navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func toUser(_ id: String) {
        let navigator = DefaultDetailUserNavigator(navigationController: navigationController)
        let viewModel = DetailUserViewModel(userId: id, useCase: services.makeUsersUseCase(), navigator: navigator)
        let vc = storyBoard.instantiateViewController(ofType: DetailUserViewController.self)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
