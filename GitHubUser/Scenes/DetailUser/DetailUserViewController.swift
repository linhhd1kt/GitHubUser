import UIKit
import RxSwift
import RxCocoa
import Domain

final class DetailUserViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var bioLabel: UILabel!
	@IBOutlet weak var publicRepoCountLabel: UILabel!
	@IBOutlet weak var followersCountLabel: UILabel!
	@IBOutlet weak var followingCountLabel: UILabel!
	
    var viewModel: DetailUserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureNavigation()
		bindViewModel()
    }
	
	private func configureNavigation() {
		title = "User detail"
//		self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(
	}

	
	private func bindViewModel() {
		assert(viewModel != nil)
		let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
			.mapToVoid()
			.asDriverOnErrorJustComplete()

		let input = DetailUserViewModel.Input(viewWillAppearTrigger: viewWillAppear)
		let output = viewModel.transform(input: input)
		
		output.user
			.drive(detailUserBinding)
			.disposed(by: disposeBag)
//		output.users.drive(tableView.rx.items(cellIdentifier: UserTableViewCell.reuseID, cellType: UserTableViewCell.self)) { tv, viewModel, cell in
//			cell.bind(viewModel)
//			}.disposed(by: disposeBag)
//
//		output.fetching
//			.drive(tableView.refreshControl!.rx.isRefreshing)
//			.disposed(by: disposeBag)
//		output.selectedUserId
//			.drive()
//			.disposed(by: disposeBag)
	}

    var detailUserBinding: Binder<DetailUserItemViewModel> {
        return Binder(self, binding: { (vc, detailUser) in
			vc.avatar.kf.setImage(with: URL(string: detailUser.avatarUrl), placeholder: #imageLiteral(resourceName: "chessboard"))
			vc.usernameLabel.text = detailUser.username
			vc.locationLabel.text = detailUser.location
			vc.bioLabel.text = detailUser.bio
			vc.publicRepoCountLabel.text = "\(detailUser.publicRepos)"
			vc.followersCountLabel.text = "\(detailUser.followers)"
			vc.followingCountLabel.text = "\(detailUser.following)"
        })
    }

    var errorBinding: Binder<Error> {
        return Binder(self, binding: { (vc, _) in
            let alert = UIAlertController(title: "Save Error",
                                          message: "Something went wrong",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss",
                                       style: UIAlertAction.Style.cancel,
                                       handler: nil)
            alert.addAction(action)
            vc.present(alert, animated: true, completion: nil)
        })
    }
}



extension Reactive where Base: UITextView {
    var isEditable: Binder<Bool> {
        return Binder(self.base, binding: { (textView, isEditable) in
            textView.isEditable = isEditable
        })
    }
}
