//
//  ResultsViewController.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-27.
//

import UIKit

class ResultsViewController: UIViewController {

    let user : UserModel

    
    init(user: UserModel) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let resultsLabel : UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let playAgainButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Play Again", for: .normal)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = 7
        button.backgroundColor = .tertiaryLabel
        
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(resultsLabel)
        view.addSubview(playAgainButton)
        playAgainButton.addTarget(self, action: #selector(didtapPlayAgain), for: .touchUpInside)
        
        navigationController?.navigationBar.isHidden = true

        displayResults()
        saveUserData()

        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let labelSize : CGFloat = view.width - 20
        
        resultsLabel.frame = CGRect(x: (view.width - labelSize)/2, y: 100, width: labelSize, height: labelSize)
        
        playAgainButton.frame = CGRect(x: (view.width-350)/2, y: resultsLabel.bottom + 50, width: 350, height: 50)
        
    }
    
    
    private func displayResults(){
       
        let number = (user.count/10) * 100
        let percentage = String(format: "%.0f", number)
       
        switch user.points{
            
        case (0...50):
            resultsLabel.text = "Lol, you could use some more work \(user.username) \n \n   \(percentage)% correct"
            
        case (51...80): resultsLabel.text = "Not bad, good work \(user.username) \n \n  \(percentage)% correct "
        
        case (81...100): resultsLabel.text = "Let's gooo! 💪 \(user.username) \n \n  \(percentage)% correct"
            
        default: return
        }
        
        
    }
    
    private func saveUserData(){
        
        DatabaseManager.shared.saveUser(model: self.user) { result in
            if result {
                print("success")
            }
            else{print("failure")}
        }
    }
    
    @objc func didtapPlayAgain(){
        navigationController?.popToRootViewController(animated: true)
        
    }
    

    

    

}
