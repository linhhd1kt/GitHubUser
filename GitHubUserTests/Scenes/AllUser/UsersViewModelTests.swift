@testable import GitHubUser
import Domain
import XCTest
import RxSwift
import RxCocoa
import RxBlocking

enum TestError: Error {
	case test
}

class UsersViewModelTests: XCTestCase {
	
	var allUserUseCase: UserUseCaseMock!
	var usersNavigator: UsersNavigatorMock!
	var viewModel: UsersViewModel!
	
	let disposeBag = DisposeBag()
	
	override func setUp() {
		super.setUp()
		
		allUserUseCase = UserUseCaseMock()
		usersNavigator = UsersNavigatorMock()
		
		viewModel = UsersViewModel(useCase: allUserUseCase,
								   navigator: usersNavigator)
	}
	
	// 1. Write a test to ensure total amount of all users are loaded
	func test_transform_totalAmounOfAllUser_loaded() {
		// arrange
		let trigger = PublishSubject<Void>()
		let output = viewModel.transform(input: createInput(viewWillAppearTrigger: trigger))
		allUserUseCase.users_ReturnValue = Observable.just(createUsers())
		
		// act
		output.users.drive().disposed(by: disposeBag)
		trigger.onNext(())
		let users = try! output.users.toBlocking().first()!
		
		// assert
		XCTAssertEqual(users.count, 3)
	}
	
	func test_transform_viewWillAppearTriggerInvoked() {
		// arrange
		let trigger = PublishSubject<Void>()
		let input = createInput(viewWillAppearTrigger: trigger)
		let output = viewModel.transform(input: input)
		
		// act
		output.users.drive().disposed(by: disposeBag)
		trigger.onNext(())
		
		// assert
		XCTAssert(allUserUseCase.users_Called)
	}
	
	func test_transform_fetchUser_trackFetching() {
		// arrange
		let trigger = PublishSubject<Void>()
		let output = viewModel.transform(input: createInput(viewWillAppearTrigger: trigger))
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
	
	func test_transform_UserEmitError_trackError() {
		// arrange
		let trigger = PublishSubject<Void>()
		let output = viewModel.transform(input: createInput(viewWillAppearTrigger: trigger))
		allUserUseCase.users_ReturnValue = Observable.error(TestError.test)
		
		// act
		output.users.drive().disposed(by: disposeBag)
		output.error.drive().disposed(by: disposeBag)
		trigger.onNext(())
		let error = try! output.error.toBlocking().first()
		
		// assert
		XCTAssertNotNil(error)
	}
	
	func test_transform_selectedUserInvoked_navigateToUser() {
		// arrange
		let select = PublishSubject<IndexPath>()
		let output = viewModel.transform(input: createInput(selection: select))
		let users = createUsers()
		allUserUseCase.users_ReturnValue = Observable.just(users)
		
		// act
		output.users.drive().disposed(by: disposeBag)
		output.selectedUserId.drive().disposed(by: disposeBag)
		select.onNext(IndexPath(row: 1, section: 0))
		
		// assert
		XCTAssertTrue(usersNavigator.toUser_Called)
		XCTAssertEqual(usersNavigator.toUser_ReceivedArguments, users[1].login)
	}
	
	private func createInput(viewWillAppearTrigger: Observable<Void> = Observable.just(()),
							 selection: Observable<IndexPath> = Observable.never())
		-> UsersViewModel.Input {
			return UsersViewModel.Input(
				trigger: viewWillAppearTrigger.asDriverOnErrorJustComplete(),
				selection: selection.asDriverOnErrorJustComplete())
	}
	
	private func createUsers() -> [User] {
		return [
			User(login: "mojombo",
				 id: 1,
				 avatarUrl: "https://avatars0.githubusercontent.com/u/1?v=4",
				 htmlUrl: "https://github.com/mojombo",
				 name: "Michael",
				 location: "San Francisco, CA",
				 bio: "",
				 publicRepos: 3,
				 followers: 18,
				 following: 0),
			User(login: "defunkt",
				 id: 2,
				 avatarUrl: "https://avatars0.githubusercontent.com/u/2?v=4",
				 htmlUrl: "https://github.com/defunkt",
				 name: "Chris Wanstrath",
				 location: "",
				 bio: "🍔",
				 publicRepos: 107,
				 followers: 20791,
				 following: 210),
			User(login: "pjhyett",
				 id: 3,
				 avatarUrl: "https://avatars0.githubusercontent.com/u/3?v=4",
				 htmlUrl: "https://github.com/pjhyett",
				 name: "PJ Hyett",
				 location: "San Francisco",
				 bio: "",
				 publicRepos: 8,
				 followers: 8190,
				 following: 30)
		]
	}
}
