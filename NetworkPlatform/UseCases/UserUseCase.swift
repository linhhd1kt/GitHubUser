import Foundation
import Domain
import RxSwift

final class UsersUseCase<Cache>: Domain.UserUseCase where Cache: AbstractCache, Cache.T == User {
    private let network: UsersNetwork
    private let cache: Cache

    init(network: UsersNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    func users() -> Observable<[User]> {
		let fetchUsers = cache.fetchObjects().asObservable()
        let stored = network.fetchUsers()
            .flatMap {
                return self.cache.save(objects: $0)
                    .asObservable()
                    .map(to: [User].self)
                    .concat(Observable.just($0))
            }
        
        return fetchUsers.concat(stored)
    }
	
	func user(id: String) -> Observable<User> {
		let fetchUser = cache.fetch(withID: id).asObservable()
		let stored = network.fetchUser(id: id)
			.flatMap {
				return self.cache.save(object: $0)					
					.asObservable()
					.map(to: User.self)
					.concat(Observable.just($0))
		}
		
		return fetchUser.concat(stored)
	}
}

struct MapFromNever: Error {}
extension ObservableType where Element == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
