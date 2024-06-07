//
//  APINetwork.swift
//  pustak-superAdmin
//
//  Created by Abhay(IOS) on 02/06/24.
//

import Foundation


class SessionManager: ObservableObject{
    @Published var isAuthenticated: Bool = false
    @Published var token: String = ""
    
    init(){
        guard let token = UserDefaults.standard.object(forKey: "token") as? String
        else {
            self.token = ""
            return
        }
        
        self.token = token
    }
}

class AuthenticationNetwork:ObservableObject{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    func validateSuperAdmin(with id: String) async throws {
        guard let url = URL(string: "\(apiURL)super-admin?id=\(id)") else {return}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8)!)
        guard let response = response as? HTTPURLResponse else {return}
        
        switch response.statusCode{
        case 400...499:
            DispatchQueue.main.async{
                self.isLoading = false
                self.isError = true
            }
        default:
            break;
        }
        
        guard let dt = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
        guard let token = dt["token"] as? String else { return }
        UserDefaults.standard.set(token, forKey: "token")
        
        DispatchQueue.main.async{
            self.isLoading = false
        }
    }
}

class LibraryAdminManager: ObservableObject{
    @Published var admins: [LibraryAdmin] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    func createAdmin(with admin: LibraryAdmin) async throws {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {return}
        guard let url = URL(string: "\(apiURL)library-admin/create") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let jsonData = try JSONEncoder().encode(admin)
//        print(admin)
        request.httpBody = jsonData
//        print("Request: \(request)")
//        print(token)
//        print("Request Body: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
        let (_ ,_ ) = try await URLSession.shared.data(for: request)
        DispatchQueue.main.async{
            self.admins.insert(admin, at: 0)
            self.isLoading = false
        }
    }
    
    func fetchUsers() async throws {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {return}
        guard let url = URL(string: "\(apiURL)library-admin/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        let admins = try JSONDecoder().decode([LibraryAdmin].self, from: data)
        DispatchQueue.main.async{
            self.admins = admins
            self.admins.sort(by: >)
            self.isLoading = false
        }
    }
}
