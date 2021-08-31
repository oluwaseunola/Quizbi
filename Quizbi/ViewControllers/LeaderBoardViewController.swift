//
//  LeaderBoardViewController.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-31.
//

import UIKit

class LeaderBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    
    private var userModels : [UserModel] = []
    private var tableview : UITableView?
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leader Board"
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        fetchUserData()
        
        
    }
    
  
    
    
    private func fetchUserData(){
        
        DatabaseManager.shared.getUsers { results in
        
            
            DispatchQueue.main.async {
                self.userModels = results
                
                self.configureTableView()
            }
            
        }
        
    }
    
    private func configureTableView(){
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        self.tableview = tableView
        view.addSubview(tableview ?? UITableView())



        
    }
    
    

    
    
//MARK: - TableView Delegate functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let organizedList = userModels.sorted(by: {$0.points > $1.points})
        
        guard let cell = tableview?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) else {return UITableViewCell()}
        
        cell.textLabel?.textAlignment = .center
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(organizedList[indexPath.row].username)"
        
        print (userModels)
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview?.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            
            return "Leader Board"
            
        }
        return nil
    }
    

}
