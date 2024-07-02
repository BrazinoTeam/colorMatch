//
//  PostService.swift
import Foundation

enum PostServiceError: Error {
    case unkonwn
    case noData
}

class PostService {
    
    static let shared = PostService()
    private init() {}
     
    private let baseUrl = "https://color-match.br-soft.online/api/user/balance-update"

    func createPlayerUser(username: String) async throws -> PlayerNetworkModel {
           
           guard let token = AuthService.shared.token else { return .defaultInstance }
           
           let password = "fotRam-murpo0-todwiv"
           let urlString = "https://color-match.br-soft.online/api/user?username=\(username)&password=\(password)"
           guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return .defaultInstance }
           var request = URLRequest(url: url)
                   
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
           
           let (data, _) = try await URLSession.shared.data(for: request)
           print(String(data: data, encoding: .utf8) ?? "No Data")
           let decoder = JSONDecoder()
           return try decoder.decode(PlayerNetworkModel.self, from: data)
       }
       
       struct Body: Codable {
           let name: String
           let username: String
           let password: String
           let imageURL: String
       }
       
       struct PlayerNetworkModel: Decodable, Identifiable {
           var id: Int
           var name: String?
           var balance: Int
           
           var unwrappedName: String {
               name ?? ""
           }
           
           static var defaultInstance: PlayerNetworkModel {
               .init(id: -1, name: "", balance: 0)
           }
       }

    func updateBalance(id: Int, payload: UpdatePayload, completion: @escaping (Result<CreateResponse, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + "/\(id)") else {
            completion(.failure(PostServiceError.unkonwn))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let json = try? JSONEncoder().encode(payload)
        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = AuthService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    guard let data else { return }
                    let model = try JSONDecoder().decode(CreateResponse.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
   }


