import UIKit

final class ImagesListViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    private let photosName: [String] = Array(1..<18).map{"\($0)"}
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    // MARK: - Private Methods
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let currentImage = photosName[indexPath.row]
        guard let image = UIImage(named: currentImage) else { return }
        cell.imageViewCell.image = image
        
        cell.dateLabel.text = dateFormatter.string(from: Date())
        
        if indexPath.row % 2 == 1 {
            cell.heartButton.imageView?.image = UIImage(named: "FavoritesActive")
        } else {
            cell.heartButton.imageView?.image = UIImage(named: "FavoritesNoActive")
        }
    }
}

// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = photosName[indexPath.row]
        guard let image = UIImage(named: currentImage) else { return 0 }
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        let cellWidth = tableView.bounds.width
        let scale = cellWidth / imageWidth
        
        return (imageHeight + 8) * scale
    }
}
