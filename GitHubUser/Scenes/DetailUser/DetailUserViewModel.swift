import Domain
import RxSwift
import RxCocoa

final class DetailUserViewModel: ViewModelType {
	private let userId: String
	private let useCase: UserUseCase
	private let navigator: DetailUserNavigator
	
	init(userId: String, useCase: UserUseCase, navigator: DetailUserNavigator) {
		self.userId = userId
		self.useCase = useCase
		self.navigator = navigator
	}
	
	func transform(input: Input) -> Output {
		let activityIndicator = ActivityIndicator()
		let errorTracker = ErrorTracker()
		let user = input.viewWillAppearTrigger
			.withLatestFrom(Driver.just(self.userId))
				.flatMapLatest { id in
					return self.useCase.user(id: id)
						.trackActivity(activityIndicator)
						.trackError(errorTracker)
						.asDriverOnErrorJustComplete()
						.map { DetailUserItemViewModel(with: $0) }
			}
		return Output(user: user)
	}
}

extension DetailUserViewModel {
	struct Input {
		let viewWillAppearTrigger: Driver<Void>
	}
	
	struct Output {
		let user: Driver<DetailUserItemViewModel>
	}
}
