import Foundation
import Domain
import RxSwift
import RxCocoa

final class UsersViewModel: ViewModelType {

    struct Input {
        let viewWillAppearTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let users: Driver<[UserItemViewModel]>
        let selectedUserId: Driver<String>
        let error: Driver<Error>
    }

    private let useCase: UserUseCase
    private let navigator: UsersNavigator
    
    init(useCase: UserUseCase, navigator: UsersNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
		let users = input.viewWillAppearTrigger.flatMapLatest { _ in
            return self.useCase.users()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
				.do(onNext: { (users) in
					print(users)
				})
                .asDriverOnErrorJustComplete()
                .map { $0.map { UserItemViewModel(with: $0) } }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedUserId = input.selection
            .withLatestFrom(users) { (indexPath, users) -> String in
                return users[indexPath.row].login
            }
			.do(onNext: { login in
				self.navigator.toUser(login)
			})
		
        return Output(fetching: fetching,
                      users: users,
                      selectedUserId: selectedUserId,
                      error: errors)
    }
}
