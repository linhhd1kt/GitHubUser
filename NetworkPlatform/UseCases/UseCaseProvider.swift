import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makeUsersUseCase() -> Domain.UserUseCase {
        return UsersUseCase(network: networkProvider.makeUsersNetwork(),
                               cache: Cache<User>(path: "users"))
    }
}
