import Domain
import RxSwift

public final class UsersNetwork {
    private let network: Network<User>

    init(network: Network<User>) {
        self.network = network
    }

    public func fetchUsers() -> Observable<[User]> {
        return network.getItems("users")
    }

    public func fetchUser(id: String) -> Observable<User> {
        return network.getItem("users", itemId: id)
    }
}
