//
//  AuthService.swift


import Foundation

class AuthService {
    
    static let shared = AuthService()
    
    var token: String?
    private var name = "admin"
    private var password = "fotRam-murpo0-todwiv"
    let url = URL(string: "https://color-match.br-soft.online/login")!
    var request: URLRequest
    
    init() {
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let data : Data = "username=\(name)&password=\(password)&grant_type=password".data(using: .utf8)!
        request.httpBody = data
       }
    
    struct AuthResponse: Codable {
        let token: String?
    }

    func authenticate() async throws {
        do {
            let config = URLSessionConfiguration.default
            config.urlCache = nil
            config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let session = URLSession(configuration: config)
            let (data, response) = try await session.data(for: request)
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json data malformed")
            }
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            self.token = authResponse.token
        } catch {
            print("error -- \(error)")
            throw error
        }
    }
}
