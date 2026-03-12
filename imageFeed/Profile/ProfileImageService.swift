import UIKit

final class ProfileImageService {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name("didChangeNotification")
    private init() {}
    
    private let decoder = JSONDecoder()
    private var task: URLSessionTask?
    private(set) var avatarURL: String?
    
    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        task?.cancel()
        
        guard let token = OAuth2TokenStorage.shared.token else {
            print("[ProfileImageService]: не удалось получить token из OAuth2TokenStorage")
            return
        }
        guard let request = makeProfileImageURLRequest(token: token, useername: username) else {
            print("[ProfileImageService]: не удалось создать request")
            return
        }
        let task = URLSession.shared.objectTask(for: request) { (result: Result<UserResult, any Error>) in
            switch result {
            case .success(let response):
                let image = response.profileImage.small
                self.avatarURL = image
                completion(.success(image))
                NotificationCenter.default.post(name: ProfileImageService.didChangeNotification, object: self, userInfo: ["URL": image])
            case .failure(let error):
                print("[ProfileImageService]: UserResult - \(error.localizedDescription)")
                completion(.failure(error))
            }
            self.task = nil
        }
        
//        let task = URLSession.shared.data(for: request) { (result: Result<Data, Error>) in
//            switch result {
//            case .success(let data):
//                do {
//                    let response = try self.decoder.decode(UserResult.self, from: data)
//                    let image = response.profileImage.small
//                    self.avatarURL = image
//                    completion(.success(image))
//                    NotificationCenter.default.post(name: ProfileImageService.didChangeNotification, object: self, userInfo: ["URL": image])
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//            self.task = nil
//        }
        self.task = task
        task.resume()
    }
    
    private func makeProfileImageURLRequest(token: String, useername: String) -> URLRequest? {
        guard
            var urlComponents = URLComponents(string: Constants.defaultBaseURLString)
        else {
            print("не удалось создать URLComponents")
            return nil
        }
        
        urlComponents.path = "/users/"+useername
        
        guard
            let url = urlComponents.url
        else {
            print("не удалось получить url из URLComponents")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

private struct UserResult: Codable {
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

private struct ProfileImage: Codable {
    let small: String
}
