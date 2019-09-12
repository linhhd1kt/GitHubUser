import Foundation

public struct User: Codable {
	public let login: String
	public let id: Int
	public let avatarUrl: String
	public let htmlUrl: String
	public let name: String
	public let location: String
	public let bio: String
	public let publicRepos: Int
	public let followers: Int
	public let following: Int
	
	public init(login: String,
				id: Int,
				avatarUrl: String,
				htmlUrl: String,
				name: String,
				location: String,
				bio: String,
				publicRepos: Int,
				followers: Int,
				following: Int
		) {
		self.login = login
		self.id = id
		self.avatarUrl = avatarUrl
		self.htmlUrl = htmlUrl
		self.name = name
		self.location = location
		self.bio = bio
		self.publicRepos = publicRepos
		self.followers = followers
		self.following = following
	}
	
	private enum CodingKeys: String, CodingKey {
		case login = "login"
		case id = "id"
		case avatarUrl = "avatar_url"
		case htmlUrl = "html_url"
		case name = "name"
		case location = "location"
		case bio = "bio"
		case publicRepos = "public_repos"
		case followers = "followers"
		case following = "following"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		login = try container.decode(String.self, forKey: .login)
		id = try container.decode(Int.self, forKey: .id)
		avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
		htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
		name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
		location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
		bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
		publicRepos = try container.decodeIfPresent(Int.self, forKey: .publicRepos) ?? 0
		followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
		following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
	}
}

extension User: Equatable {
	public static func == (lhs: User, rhs: User) -> Bool {
		return lhs.login == rhs.login &&
			lhs.id == rhs.id &&
			lhs.avatarUrl == rhs.avatarUrl &&
			lhs.htmlUrl == rhs.htmlUrl &&
			lhs.name == rhs.name &&
			lhs.location == rhs.location &&
			lhs.bio == rhs.bio &&
			lhs.publicRepos == rhs.publicRepos &&
			lhs.followers == rhs.followers &&
			lhs.following == rhs.following
	}
}
