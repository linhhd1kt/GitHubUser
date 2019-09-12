import Domain

extension User: Identifiable {}

extension User {
    func toJSON() -> [String: Any] {
        return [
            "login": login,
            "id": id,
            "avatar_url": avatarUrl,
			"html_url": htmlUrl,
			"name": name,
			"location": location,
			"bio": bio,
			"public_repos": publicRepos,
			"followers": followers,
			"following": following
        ]
    }
}

extension User: Encodable {
    var encoder: NETUser {
        return NETUser(with: self)
    }
}

final class NETUser: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let login = "login"
        static let id = "id"
        static let avatarUrl = "avatarUrl"
		static let htmlUrl = "htmlUrl"
		static let name = "name"
		static let location = "location"
		static let bio = "bio"
		static let publicRepos = "publicRepos"
		static let followers = "followers"
		static let following = "following"
    }
    let login: String
    let id: Int
    let avatarUrl: String
	let htmlUrl: String
	let name: String
	let location: String
	let bio: String
	let publicRepos: Int
	let followers: Int
	let following: Int

    init(with domain: User) {
        self.login = domain.login
		self.id = domain.id
		self.avatarUrl = domain.avatarUrl
		self.htmlUrl = domain.htmlUrl
		self.name = domain.name
		self.location = domain.location
		self.bio = domain.bio
		self.publicRepos = domain.publicRepos
		self.followers = domain.followers
		self.following = domain.following
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
			let login = aDecoder.decodeObject(forKey: Keys.login) as? String,
			let id = aDecoder.decodeObject(forKey: Keys.id) as? Int,
			let avatarUrl = aDecoder.decodeObject(forKey: Keys.avatarUrl) as? String,
			let htmlUrl = aDecoder.decodeObject(forKey: Keys.htmlUrl) as? String,
			let name = aDecoder.decodeObject(forKey: Keys.name) as? String,
			let location = aDecoder.decodeObject(forKey: Keys.location) as? String,
			let bio = aDecoder.decodeObject(forKey: Keys.bio) as? String,
			let publicRepos = aDecoder.decodeObject(forKey: Keys.publicRepos) as? Int,
			let followers = aDecoder.decodeObject(forKey: Keys.followers) as? Int,
			let following = aDecoder.decodeObject(forKey: Keys.following) as? Int
        else {
            return nil
        }
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(login, forKey: Keys.login)
        aCoder.encode(id, forKey: Keys.id)
        aCoder.encode(avatarUrl, forKey: Keys.avatarUrl)
		aCoder.encode(htmlUrl, forKey: Keys.htmlUrl)
		aCoder.encode(name, forKey: Keys.name)
		aCoder.encode(location, forKey: Keys.location)
		aCoder.encode(bio, forKey: Keys.bio)
		aCoder.encode(publicRepos, forKey: Keys.publicRepos)
		aCoder.encode(followers, forKey: Keys.followers)
		aCoder.encode(following, forKey: Keys.following)
    }
    
    func asDomain() -> User {
		return User(login: login,
					id: id,
					avatarUrl: avatarUrl,
					htmlUrl: htmlUrl,
					name: name,
					location: location,
					bio: bio,
					publicRepos: publicRepos,
					followers: followers,
					following: following
		)
    }
}
