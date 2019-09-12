import Foundation
import Domain

final class DetailUserItemViewModel {
	let username: String
	let avatarUrl: String
	let location: String
	let bio: String
	let publicRepos: Int
	let followers: Int
	let following: Int
	
	init (with user: User) {
		self.username = user.name
		self.avatarUrl = user.avatarUrl
		self.location = user.location
		self.bio = user.bio
		self.publicRepos = user.publicRepos
		self.followers = user.followers
		self.following = user.following
	}
}
