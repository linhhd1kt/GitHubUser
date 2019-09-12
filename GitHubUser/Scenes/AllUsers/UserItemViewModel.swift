import Foundation
import Domain

final class UserItemViewModel {
	let id: Int
    let login: String
    let htmlUrl: String
    let avatarUrl: String
    init (with user: User) {
		self.id = user.id
        self.login = user.login
        self.avatarUrl = user.avatarUrl
        self.htmlUrl = user.htmlUrl
    }
}
