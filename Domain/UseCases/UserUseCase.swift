import Foundation
import RxSwift

public protocol UserUseCase {
    func users() -> Observable<[User]>
	func user(id: String) -> Observable<User>
}
