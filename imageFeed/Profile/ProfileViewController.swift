import UIKit

final class ProfileViewController: UIViewController {
    private var profileUiImage = UIImageView()
    private var nameUiImage = UILabel()
    private var usernameUiImage = UILabel()
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImage()
        setupLogout()
        if let profile = ProfileService.shared.profile {
            setupProfile(profile: profile)
        }
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(forName: ProfileImageService.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.updateAvatar()
        }
        updateAvatar()
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
    
    private func setupNameLabel(text: String) {
        let uiLabel = UILabel()
        view.addSubview(uiLabel)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        uiLabel.leadingAnchor.constraint(equalTo: profileUiImage.leadingAnchor).isActive = true
        uiLabel.topAnchor.constraint(equalTo: profileUiImage.bottomAnchor, constant: 8).isActive = true
        uiLabel.text = text
        uiLabel.textColor = .ypWhite
        
        nameUiImage = uiLabel
    }
    
    private func setupUsername(text: String) {
        let uiLabel = UILabel()
        view.addSubview(uiLabel)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        uiLabel.leadingAnchor.constraint(equalTo: nameUiImage.leadingAnchor).isActive = true
        uiLabel.topAnchor.constraint(equalTo: nameUiImage.bottomAnchor, constant: 8).isActive = true
        uiLabel.text = text
        uiLabel.textColor = .ypGray
        
        usernameUiImage = uiLabel
    }
    
    private func setupBio(text: String) {
        let uiLabel = UILabel()
        view.addSubview(uiLabel)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        uiLabel.leadingAnchor.constraint(equalTo: usernameUiImage.leadingAnchor).isActive = true
        uiLabel.topAnchor.constraint(equalTo: usernameUiImage.bottomAnchor, constant: 8).isActive = true
        uiLabel.text = text
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
    
//    private func setupProfileService() {
//        guard let token = OAuth2TokenStorage.shared.token else { return }
//        ProfileService.shared.fetchProfile(token) { result in
//            switch result {
//            case .success(let profile):
//                self.setupProfile(profile: profile)
//                print("setupProfileService success")
//                
//            case .failure(let error):
//                print("error: \(error)")
//            }
//        }
//    }
    
    private func setupProfile(profile: Profile) {
        setupNameLabel(text: profile.name)
        setupUsername(text: profile.loginName)
        setupBio(text: profile.bio)
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        // TODO [Sprint 11] Обновить аватар, используя Kingfisher
    }
    
//    override init(nibName: String?, bundle: Bundle?) {
//        super.init(nibName: nibName, bundle: bundle)
//        addObserver()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        addObserver()
//    }
//    deinit {
//        removeObserver()
//    }
//    private func addObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(updateAvatar(notification:)), name: ProfileImageService.didChangeNotification, object: nil)
//    }
//    private func removeObserver() {
//        NotificationCenter.default.removeObserver(self, name: ProfileImageService.didChangeNotification, object: nil)
//    }
//    @objc
//    private func updateAvatar(notification: Notification) {
//        guard
//            isViewLoaded,
//            let userInfo = notification.userInfo,
//            let profileImageURL = userInfo["URL"] as? String,
//            let url = URL(string: profileImageURL)
//        else { return }
//        // TODO [Sprint 11] Обновите аватар, используя Kingfisher
//    }
}
