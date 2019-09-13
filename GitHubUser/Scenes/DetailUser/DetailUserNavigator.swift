import Foundation
import UIKit
import Domain

protocol DetailUserNavigator {
    func toUsers()
}

final class DefaultDetailUserNavigator: DetailUserNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toUsers() {
        navigationController.popViewController(animated: true)
    }
}
