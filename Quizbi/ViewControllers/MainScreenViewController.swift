//
//  ViewController.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-25.
//

import UIKit

class MainScreenViewController: UIViewController {

    
    //MARK: - Views
    
    private var thing : [Questions] = []

    private var keyboardHeight : CGFloat = 0

    private let headerView : UIView = {
        
        let background = UIImageView(image: UIImage(named: "gradient"))
        
        let view = UIView()
        
        view.addSubview(background)
    
        view.clipsToBounds = true
        
        
        
        return view
        
    }()
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        
        label.text = "Your solution to bordome."
        label.textAlignment  = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(named: "HeaderColor")
        
        return label
        
    }()

    private let logoView : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Quizbi")

        
        return view
        
    }()
    
    private let nameText : UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.placeholder = "Enter your name"
        field.layer.borderWidth = 5
        field.layer.borderColor = UIColor.systemBackground.cgColor
        field.layer.cornerRadius = 7
        field.textColor = .black
        
        
        
        return field
    }()
    
    private let playButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Play!", for: .normal)
        button.tintColor = .label
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.cornerRadius = 7
        button.setTitleColor(.label, for: .normal)
        
        
        
        
        return button
    }()
    
    private let leaderBoard : UIButton = {
        let button = UIButton()
        
        button.setTitle("Leader Board", for: .normal)
        button.tintColor = .label
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.cornerRadius = 7
        button.setTitleColor(.label, for: .normal)
        
        
        
        return button
    }()
    
    
    
    
  
    
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerView)
        view.addSubview(logoView)
        view.addSubview(nameText)
        view.addSubview(playButton)
        view.addSubview(leaderBoard)
        view.addSubview(titleLabel)
        
        playButton.addTarget(self, action: #selector(didTapPLay), for: .touchUpInside)
        nameText.delegate = self
        
        leaderBoard.addTarget(self, action: #selector(didTapLeaderBoard), for: .touchUpInside)
        
        navigationController?.isNavigationBarHidden = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapAway))
        
        view.addGestureRecognizer(gesture)
        
        view.backgroundColor = .systemBackground
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        headerView.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
        
        let labelSize = view.width - 20
        
        titleLabel.frame = CGRect(x: (view.width - labelSize)/2, y: 100, width: labelSize, height: 100)
        
        
        let logoSize : CGFloat = 500
        
        logoView.frame = CGRect(x: (view.width - logoSize)/2, y: ((view.height - logoSize)/2) - 100 , width: logoSize, height: logoSize)
        
        logoView.layer.cornerRadius = 15
        
        
        
    
        nameText.frame = CGRect(x: (view.width-300)/2, y: logoView.bottom-100, width: 300, height: 50)
        
        
        playButton.frame = CGRect(x: (view.width-300)/2, y: nameText.bottom + 8, width: 300, height: 50)
        
        leaderBoard.frame = CGRect(x: (view.width-300)/2, y: playButton.bottom + 8, width: 300, height: 50)
        
    }
    
    //MARK: - text field functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = nameText.text else {return false}
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty || nameText.text?.count ?? 0 > 10 {
            
            let alert = UIAlertController(title: "Error", message: "Please enter a valid name less than 10 characters", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            
            HapticsViewController.shared.vibrate(for: .warning)
        }
        
        
        
        UserDefaults.standard.set(text, forKey: "username")
        nameText.text = nil
        nameText.resignFirstResponder()
        
        let vc = GameViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        return true
    }


    //MARK: - Button Actions
    
    @objc func didTapPLay(){
        if !(nameText.text?.isEmpty ?? true) && nameText.text?.count ?? 0 <= 10{
            
            let vc = GameViewController()
            
            navigationController?.pushViewController(vc, animated: true)
            
            let text = nameText.text
            
            UserDefaults.standard.set(text, forKey: "username")
            
            nameText.text = nil
            nameText.resignFirstResponder()

            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Please enter a valid name less than 10 characters", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            
            HapticsViewController.shared.vibrate(for: .warning)
        }
       

    }
    
    @objc func didTapLeaderBoard(){
        
        let vc = LeaderBoardViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MainScreenViewController : UITextFieldDelegate {
    
    //MARK: - Textfield delegates
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            
            nameText.frame = CGRect(x: (view.width-300)/2, y: view.height - keyboardHeight-50, width: 300, height: 50)
        }
        

    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
       
        nameText.frame = CGRect(x: (view.width-300)/2, y: logoView.bottom-100, width: 300, height: 50)
    }

@objc func didTapAway(){
    nameText.resignFirstResponder()
}

}
    
    

