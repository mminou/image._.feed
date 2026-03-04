import UIKit

final class OAuth2Service {
    
    // MARK: - singleton
    static let shared = OAuth2Service()
    private init() { }
    
    // MARK: - Private Properties
    private var authStorage = OAuth2TokenStorage()
    
    // MARK: - Public Methods
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let urlRequest = tokenAuthRequest(code: code) else { return }
        URLSession.shared.dataTask(with: urlRequest)
        guard let request = tokenAuthRequest(code: code) else { return }
        
        let task = URLSession.shared.data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    
                    let response = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    self.authStorage.token = response.access_token
                    
                    completion(.success(response.access_token))
                    
                } catch { completion(.failure(error)) }
            case .failure(let error):
                if let netError = error as? NetworkError {
                    switch netError {
                    case .decodingError(let error):
                        print("decoding error: \(error)")
                    case .httpStatusCode(let code):
                        print("http status code: \(code)")
                    case .invalidRequest:
                        print("invalid request")
                    case .urlRequestError(let error):
                        print("url request error: \(error)")
                    case .urlSessionError:
                        print("url session error")
                    }
                }
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    private func tokenAuthRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: WebViewConstants.unsplashAuthorizeTokenURLString) else { return nil }
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}

// MARK: - struct
struct OAuthTokenResponseBody: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
    let created_at: Int
}
