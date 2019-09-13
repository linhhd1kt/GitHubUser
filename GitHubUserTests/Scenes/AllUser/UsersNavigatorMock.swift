@testable import GitHubUser
import Domain
import RxSwift

class UsersNavigatorMock: UsersNavigator {
	
	var toUser_Called = false
	var toUser_ReceivedArguments: String = ""
	
	func toUser(_ id: String) {
		toUser_Called = true
		toUser_ReceivedArguments = id
	}	
}
