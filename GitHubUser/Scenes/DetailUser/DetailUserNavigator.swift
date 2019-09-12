import Foundation
import UIKit
import Domain

protocol DetailUserNavigator {
    func toPosts()
}

final class DefaultDetailUserNavigator: DetailUserNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toPosts() {
        navigationController.popViewController(animated: true)
    }
}
