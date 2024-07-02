//
//  GetService.swift


import Foundation

enum GetServiceError: Error {
    case unkonwn
    case noData
}

class GetService {
    
    static let shared = GetService()
    private init() {}
    
    private let urlString = "https://color-match.br-soft.online/api/leaderboard"
    
    func fetchData(successCompletion: @escaping([User]) -> Void, errorCompletion: @escaping (Error) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        guard let token = AuthService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    errorCompletion(GetServiceError.noData)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(GetServiceError.unkonwn)
                }
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            
            do {
                let decoder = JSONDecoder()
                let ratingModel = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    successCompletion(ratingModel)
                    print("\(ratingModel)")
                }
            }catch {
                print("error - ", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
    
    func updateUser(userId: Int, name: String) {
        let url = URL(string: "https://color-match.br-soft.online/api/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        guard let token = AuthService.shared.token else {
            print("No token found")
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n")
        body.append("\(userId)\r\n")
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n")
        body.append("\(name)\r\n")
        
        body.append("--\(boundary)--\r\n")
        
        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response: \(json)")
                } else {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response String: \(responseString)")
                    }
                }
            } catch {
                print("Error parsing response: \(error)")
            }
        }
        
        task.resume()
    }
}

extension Data {
        mutating func append(_ string: String) {
            if let data = string.data(using: .utf8) {
                append(data)
            }
        }
    }


