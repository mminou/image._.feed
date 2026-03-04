import UIKit

final class ProfileViewController: UIViewController {
    private var profileUiImage = UIImageView()
    private var nameUiImage = UILabel()
    private var usernameUiImage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImage()
        setupNameLabel()
        setupUsername()
        setupBio()
        setupLogout()
    }
    
    private func setupView() {
        view.backgroundColor = .ypBlack
    }
    
    private func setupProfileImage() {
        let uiImage = UIImageView()
        view.addSubview(uiImage)
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        uiImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        uiImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        uiImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        uiImage.image = UIImage(named: "CatAvatar")
        
        uiImage.layer.cornerRadius = 32
        uiImage.layer.masksToBounds = true
        
        profileUiImage = uiImage
    }
    
    private func setupNameLabel() {
        let uiLabel = UILabel()
        view.addSubview(uiLabel)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        uiLabel.leadingAnchor.constraint(equalTo: profileUiImage.leadingAnchor).isActive = true
        uiLabel.topAnchor.constraint(equalTo: profileUiImage.bottomAnchor, constant: 8).isActive = true
        uiLabel.text = "avocado"
        uiLabel.textColor = .ypWhite
        
        nameUiImage = uiLabel
    }
    
    private func setupUsername() {
        let uiLabel = UILabel()
        view.addSubview(uiLabel)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        uiLabel.leadingAnchor.constraint(equalTo: nameUiImage.leadingAnchor).isActive = true
        uiLabel.topAnchor.constraint(equalTo: nameUiImage.bottomAnchor, constant: 8).isActive = true
        uiLabel.text = "@avocado"
        uiLabel.textColor = .ypGray
        
        usernameUiImage = uiLabel
    }
    
    private func setupBio() {
        let uiLabel = UILabel()
        view.addSubview(uiLabel)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        uiLabel.leadingAnchor.constraint(equalTo: usernameUiImage.leadingAnchor).isActive = true
        uiLabel.topAnchor.constraint(equalTo: usernameUiImage.bottomAnchor, constant: 8).isActive = true
        uiLabel.text = "hi"
        uiLabel.textColor = .ypWhite
    }
    
    private func setupLogout() {
        let uiButton = UIButton()
        view.addSubview(uiButton)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        uiButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        uiButton.setImage(UIImage(named: "Exit"), for: .normal)
        
        uiButton.centerYAnchor.constraint(equalTo: profileUiImage.centerYAnchor).isActive = true
        uiButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
}
