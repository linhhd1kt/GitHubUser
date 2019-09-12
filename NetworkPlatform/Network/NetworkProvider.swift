import Domain

final class NetworkProvider {
    private let apiEndpoint: String

    public init() {
        apiEndpoint = "https://api.github.com"
    }

    public func makeUsersNetwork() -> UsersNetwork {
        let network = Network<User>(apiEndpoint)
        return UsersNetwork(network: network)
    }
}
