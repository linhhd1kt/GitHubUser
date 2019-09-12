import UIKit
import Kingfisher

final class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var htlmUrlLabel: UILabel!
    
    func bind(_ viewModel: UserItemViewModel) {
        self.loginLabel.text = viewModel.login
		let url = URL(string: viewModel.avatarUrl)
		avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "chessboard"))
        self.htlmUrlLabel.text = viewModel.htmlUrl
    }
    
}
