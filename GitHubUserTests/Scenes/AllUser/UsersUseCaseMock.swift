@testable import GitHubUser
import RxSwift
import Domain

class UsersUseCaseMock: Domain.UserUseCase {
	var users_ReturnValue: Observable<[User]> = Observable.just([])
	var users_Called = false
	var user_ReturnValue: Observable<User>
		= Observable.just(User(login: "mojombo",
							   id: 1,
							   avatarUrl: "https://avatars0.githubusercontent.com/u/1?v=4",
							   htmlUrl: "https://github.com/mojombo",
							   name: "Michael",
							   location: "San Francisco, CA",
							   bio: "",
							   publicRepos: 3,
							   followers: 18,
							   following: 0))
	var user_Called = false
	
	func users() -> Observable<[User]> {
		users_Called = true
		return users_ReturnValue
	}
	
	func user(id: String) -> Observable<User> {
		user_Called = true
		return user_ReturnValue
	}
}

