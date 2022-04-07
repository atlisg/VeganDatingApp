//
//  UserListViewController.swift
//  VeganDatingApp
//
//  Created by Atli Saevar on 7.4.2022.
//

import UIKit

class UserListViewController: UIViewController {

    private let token: String
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        fetchUsers { (userData) in
            let users = userData.data.users
            print("users:")
            print(users)
        }
    }
    
    func fetchUsers(completionHandler: @escaping (UserResponse) -> Void) {
        var request = URLRequest(url: URL(string: "https://grazer-test.herokuapp.com/v1/users")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data else { return }
            
            do {
                let encoded = String(data: data, encoding: .utf8)!
                print(encoded)
                let jsonData = encoded.data(using: .utf8)
                let userData: UserResponse = try! JSONDecoder().decode(UserResponse.self, from: jsonData!)
                
                completionHandler(userData)
            }
            catch {
                let error = error
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}

