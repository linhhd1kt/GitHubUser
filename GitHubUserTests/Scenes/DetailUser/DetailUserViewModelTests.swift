@testable import GitHubUser
import Domain
import XCTest
import RxSwift
import RxCocoa
import RxBlocking

class DetailUserViewModelTests: XCTestCase {
	
	var detailUserUseCase: UserUseCaseMock!
	var detailUserNavigator: DetailUserNavigatorMock!
	var viewModel: DetailUserViewModel!
	
	let disposeBag = DisposeBag()
	
	override func setUp() {
		super.setUp()
		
		detailUserUseCase = UserUseCaseMock()
		detailUserNavigator = DetailUserNavigatorMock()
		
		viewModel = DetailUserViewModel(userId: "mojombo", useCase: detailUserUseCase,
								   navigator: detailUserNavigator)
	}

	// 2. Write a test assert following, follower of a user
	func test_transform_triggerInvoked_mapUserToViewModel() {
		// arrange
		let trigger = PublishSubject<Void>()
		let output = viewModel.transform(input: createInput(trigger: trigger))
		detailUserUseCase.detail_user_ReturnValue = Observable.just(createUser())
		
		// act
		output.user.drive().disposed(by: disposeBag)
		trigger.onNext(())
		let user = try! output.user.toBlocking().first()!
		
		// assert
		XCTAssertEqual(user.followers, 18)
		XCTAssertEqual(user.following, 0)
	}
	
	func test_transform_TriggerInvoked() {
		// arrange
		let trigger = PublishSubject<Void>()
		let input = createInput(trigger: trigger)
		let output = viewModel.transform(input: input)
		
		// act
		output.user.drive().disposed(by: disposeBag)
		trigger.onNext(())
		
		// assert
		XCTAssert(detailUserUseCase.detail_user_Called)
	}
	
	
	func test_transform_fetchdDetailUser_trackFetching() {
		// arrange
		let trigger = PublishSubject<Void>()
		let output = viewModel.transform(input: createInput(trigger: trigger))
		let expectedFetching = [true, false]
		var actualFetching: [Bool] = []
		
		// act
		output.fetching
			.do(onNext: { actualFetching.append($0) },
				onSubscribe: { actualFetching.append(true) })
			.drive()
			.disposed(by: disposeBag)
		trigger.onNext(())
		
		// assert
		XCTAssertEqual(actualFetching, expectedFetching)
	}
	
	private func createInput(trigger: Observable<Void> = Observable.just(()))
		-> DetailUserViewModel.Input {
			return DetailUserViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete())
	}
	
	private func createUser() -> User {
		return User(login: "mojombo",
					id: 1,
					avatarUrl: "https://avatars0.githubusercontent.com/u/1?v=4",
					htmlUrl: "https://github.com/mojombo",
					name: "Michael",
					location: "San Francisco, CA",
					bio: "",
					publicRepos: 3,
					followers: 18,
					following: 0)
	}
}
