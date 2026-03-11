import UIKit

final class ProfileService {
    
}

private struct ProfileResult: Codable {
    
    private func makeProfileURLRequest() {
        guard
            var urlComponents = URLComponents(string: Constants.defaultBaseURLString)
        else {
            print("не удалось создать URLComponents")
            return
        }
        urlComponents.path = "/me"
        guard
            let url = urlComponents.url
        else {
            print("не удалось получить url из URLComponents")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
    }
}

private struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String
}
