@testable import GitHubUser
import Domain
import RxSwift

class UsersNavigatorMock: UsersNavigator {
	
	var toUser_user_Called = false
	var toUser_user_ReceivedArguments: String = ""
	
	func toUser(_ id: String) {
		toUser_user_Called = true
		toUser_user_ReceivedArguments = id
	}
	
}
