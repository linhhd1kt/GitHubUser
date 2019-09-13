@testable import GitHubUser
import Domain
import RxSwift

class DetailUserNavigatorMock: DetailUserNavigator {
	
	var toUsers_Called = false
	
	func toUsers() {
		toUsers_Called = true
	}
}
