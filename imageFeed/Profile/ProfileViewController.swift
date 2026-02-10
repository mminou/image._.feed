import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var descriptonLabel: UILabel!
    @IBOutlet private weak var exitButton: UIButton!
    
    @IBAction private func tapExitButton(_ sender: Any) {
    }
}
