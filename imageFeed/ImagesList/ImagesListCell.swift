import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Public Properties
    static let reuseIdentifier = "ImagesListCell"
}
