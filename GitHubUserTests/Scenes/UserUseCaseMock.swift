@testable import GitHubUser
import RxSwift
import Domain

class UserUseCaseMock: Domain.UserUseCase {
	var users_ReturnValue: Observable<[User]> = Observable.just([])
	var users_Called = false
	var detail_user_ReturnValue: Observable<User>
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
	var detail_user_Called = false
	
	func users() -> Observable<[User]> {
		users_Called = true
		return users_ReturnValue
	}
	
	func user(id: String) -> Observable<User> {
		detail_user_Called = true
		return detail_user_ReturnValue
	}
}

