import UIKit
import Domain
import RxSwift
import RxCocoa

class UsersViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: UsersViewModel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureNavigation()
        configureTableView()
        bindViewModel()
    }
	
	private func configureNavigation() {
		title = "User List"
	}
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = UsersViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
										 selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
		
        output.users.drive(tableView.rx.items(cellIdentifier: UserTableViewCell.reuseID, cellType: UserTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: disposeBag)
		
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.selectedUserId
            .drive()
            .disposed(by: disposeBag)
    }
}



