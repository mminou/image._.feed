import UIKit

final class ProfileService {
    static let shared = ProfileService()
    private init() {}
    
    private let decoder = JSONDecoder()
    private var task: URLSessionTask?
    
    private func makeProfileURLRequest(token: String) -> URLRequest? {
        guard
            var urlComponents = URLComponents(string: Constants.defaultBaseURLString)
        else {
            print("не удалось создать URLComponents")
            return nil
        }
        
        urlComponents.path = "/me"
        
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
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        task?.cancel()
        
        guard
            let request = makeProfileURLRequest(token: token)
        else {
            print("не удалось создать request")
            return
        }
        
        let task = URLSession.shared.data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let response = try self.decoder.decode(ProfileResult.self, from: data)
                    let profile = Profile(
                        username: response.username,
                        name: "\(response.firstName) \(response.lastName)",
                        loginName: "@"+response.username,
                        bio: response.bio ?? "")
                    completion(.success(profile))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}

private struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String
}
