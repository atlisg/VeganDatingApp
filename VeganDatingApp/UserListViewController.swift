//
//  UserListViewController.swift
//  VeganDatingApp
//
//  Created by Atli Saevar on 7.4.2022.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var users: [User]

    private let token: String
    
    init(token: String) {
        self.token = token
        self.users = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        
        fetchUsers { (userData) in
            self.users = userData.data.users
            print("users:")
            print(self.users)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
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

