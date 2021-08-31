//
//  GameViewController.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-26.
//
import AVFoundation
import Lottie
import UIKit


class GameViewController: UIViewController {
    
    
    private var questions : [Questions] = []
    private var options : [String] = []
    private var currentQuestion : Questions?
    private var points = 0
    private var counter : Float = 0
    private var headerBackgrounds : [UIImage?] = [ UIImage(named: "gradient2"),UIImage(named: "gradient3"), UIImage(named: "gradient4"), UIImage(named: "gradient5")]
    private var buttonList : [UIButton?] = []
    private var animationView : AnimationView?
    private var audioPlayer : AVAudioPlayer!
    
    
    
    
    
    
    //MARK: - UI
    
    private let headerView : UIImageView = {
        
        var initial : [UIImage?] = [ UIImage(named: "gradient2"),UIImage(named: "gradient3"), UIImage(named: "gradient4"), UIImage(named: "gradient5")]
        
        let view = UIImageView()
        
        guard let randomImage = initial.randomElement() else {return UIImageView()}
        
        view.image = randomImage
        
        
        view.contentMode = .scaleAspectFill
        
        view.layer.masksToBounds = true
        
        
        
        
        
        return view
        
    }()
    
    private let icon : UIImageView = {
        let view = UIImageView()
        
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        view.image = UIImage(systemName: "person")
        view.tintColor = .label
        
        
        return view
    }()
    
    private let categoryImage : UIImageView = {
        let view = UIImageView()
        
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        
        return view
    }()
    
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        
        
        
        return label
    }()
    
    
    private let pointsLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let questionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private let buttonA : UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.imageView?.image = UIImage(systemName: "a.circle")
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = 7
        button.backgroundColor = .tertiaryLabel
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        return button
        
    }()
    
    private let buttonB : UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.imageView?.image = UIImage(systemName: "b.circle")
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = 7
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        
        
        return button
        
    }()
    
    private let buttonC : UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.imageView?.image = UIImage(systemName: "c.circle")
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = 7
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        
        
        return button
        
    }()
    
    private let buttonD : UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.imageView?.image = UIImage(systemName: "d.circle")
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = 7
        button.backgroundColor = .tertiaryLabel
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        return button
        
    }()
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(usernameLabel)
        view.addSubview(questionLabel)
        view.addSubview(pointsLabel)
        view.addSubview(icon)
        view.addSubview(categoryImage)
        configureButtons()
        configureNav()
        fetchData()
        
        
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let usernamelabelSize = view.width/3
        
        usernameLabel.frame = CGRect(x: view.width - usernamelabelSize - 40, y: view.safeAreaInsets.bottom + 10, width: usernamelabelSize, height: 50)
        
        let iconSize : CGFloat = 20
        
        icon.frame = CGRect(x: view.width - usernamelabelSize - iconSize - 50, y: view.safeAreaInsets.bottom + 25, width: iconSize, height: iconSize)
        
        categoryImage.frame = CGRect(x: (view.width-100)/2, y: usernameLabel.bottom + 50, width: 100, height: 100)
        
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/2)
        
        headerView.layer.cornerRadius = 7
        
        
        
        let labelSize = view.width - 20
        
        questionLabel.frame = CGRect(x: (view.width - labelSize)/2, y: view.height/8 , width: view.width-20, height: headerView.height-20)
        
        buttonA.frame = CGRect(x: (view.width-350)/2, y: headerView.bottom + 50, width: 350, height: 50)
        
        buttonB.frame = CGRect(x: (view.width-350)/2, y: buttonA.bottom + 10, width: 350, height: 50)
        
        buttonC.frame = CGRect(x: (view.width-350)/2, y: buttonB.bottom + 10, width: 350, height: 50)
        
        buttonD.frame = CGRect(x: (view.width-350)/2, y: buttonC.bottom + 10, width: 350, height: 50)
        
    }
    
    //MARK: - Fetch Data
    
    private func fetchData(){
        
        APICall.newQuestionSet { [weak self] question in
            
            guard let username = UserDefaults.standard.string(forKey: "username") else{return}
            
            let results = question.results
            
            self?.questions = results
            
            print(self?.questions)
            
            self?.selectQuestion()
            
            
        }
    }
    
    func configureNav(){
        
        navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    
    private func selectQuestion(){
        
        
        questions.shuffle()
        
        let randomQ = questions.removeLast()
        
        self.currentQuestion = randomQ
        
        DispatchQueue.main.async {
            self.configureCategoryBackground()
            
        }
        
        
        self.options.append(contentsOf: randomQ.incorrect_answers ?? [""])
        self.options.append(randomQ.correct_answer ?? "")
        
        self.options.shuffle()
        
        buttonList = [self.buttonA,self.buttonB,self.buttonC,self.buttonD]
        
        
        buttonList.forEach { button in
            
            DispatchQueue.main.async {
                let option = self.options.removeLast()
                button?.setTitle(String(htmlString: option), for: .normal)
                self.questionLabel.text = String(htmlString: randomQ.question)
            }
        }
        
    }
    
    private func configureButtons(){
        
        guard let username = UserDefaults.standard.string(forKey: "username") else{return}
        
        view.addSubview(buttonA)
        view.addSubview(buttonB)
        view.addSubview(buttonC)
        view.addSubview(buttonD)
        buttonA.addTarget(self, action: #selector(didTapA), for: .touchUpInside)
        buttonB.addTarget(self, action: #selector(didTapB), for: .touchUpInside)
        buttonC.addTarget(self, action: #selector(didTapC), for: .touchUpInside)
        buttonD.addTarget(self, action: #selector(didTapD), for: .touchUpInside)
        
        self.usernameLabel.text = "\(username) \(self.points)"
        
        
        
    }
    
    func refreshData(){
        
        
        
        questionLabel.text = nil
        buttonA.titleLabel?.text = nil
        buttonB.titleLabel?.text = nil
        buttonC.titleLabel?.text = nil
        buttonD.titleLabel?.text = nil
        buttonA.backgroundColor = .tertiaryLabel
        buttonB.backgroundColor = .tertiaryLabel
        buttonC.backgroundColor = .tertiaryLabel
        buttonD.backgroundColor = .tertiaryLabel
        animationView?.removeFromSuperview()
        
        buttonList.forEach { button in
            button?.isUserInteractionEnabled = true
        }
        
        
        guard let randomImage = headerBackgrounds.randomElement() else {return}
        
        headerView.image = randomImage
        
        
        
        selectQuestion()
        
        
    }
    
    
    //MARK: - button functions
    
    private func updatePoints(){
        guard let username = UserDefaults.standard.string(forKey: "username") else{return}
        points += 10
        counter += 1
        usernameLabel.text = "\(username) \(points)"
        
        
    }
    
    private func highlightCorrectAnswer(){
        
        buttonList.forEach { button in
            
            if button?.titleLabel?.text == String(htmlString: currentQuestion?.correct_answer ?? ""){
                
                button?.backgroundColor = UIColor(named: "Correct")
                
            }
            
        }
        
    }
    
    private func showResults(){
        
        if questions.isEmpty{
            
            guard let username = UserDefaults.standard.string(forKey: "username") else {return}
            
            
            let vc = ResultsViewController(user: UserModel(username: username, points: self.points, count: self.counter))
            
            navigationController?.pushViewController(vc, animated: true)
            
            return
        }
        
    }
    
    private func configureCategoryBackground(){
        
        
        switch currentQuestion?.category{
            
        case "Entertainment: Books" :
            categoryImage.image = UIImage(named: "open-book" )
        case "Celebrities" :
            categoryImage.image = UIImage(named: "celebrity" )
        case "Entertainment: Film" :
            categoryImage.image = UIImage(named: "camera" )
        case "Entertainment: Television" :
            categoryImage.image = UIImage(named: "television" )
        case "Science & Nature" :
            categoryImage.image = UIImage(named: "atom" )
        case "Entertainment: Music" :
            categoryImage.image = UIImage(named: "party" )
        case "Entertainment: Comics" :
            categoryImage.image = UIImage(named: "comic" )
        case "Art" :
            categoryImage.image = UIImage(named: "mona-lisa" )
        case "History" :
            categoryImage.image = UIImage(named: "history" )
        case "Entertainment: Musicals & Theatres" :
            categoryImage.image = UIImage(named: "theatre" )
        case "Entertainment: Video Games" :
            categoryImage.image = UIImage(named: "videogames" )
        case "Science: Gadgets" :
            categoryImage.image = UIImage(named: "gadget" )
        case "Geography" :
            categoryImage.image = UIImage(named: "geography" )
        case "Science: Computers" :
            categoryImage.image = UIImage(named: "desktop" )
        case "Entertainment: Japanese Anime & Manga" :
            categoryImage.image = UIImage(named: "gundam" )
        case "Vehicles":
            categoryImage.image = UIImage(named: "car" )
        case "Sports" :
            categoryImage.image = UIImage(named: "sports" )
        default:
            categoryImage.image = UIImage(named: "question" )
            
            
            
            
            
        }
        
    }
    
    private func playAnimation(){
        if let url = Bundle.main.url(forResource: "correct", withExtension: "mp3"){
            audioPlayer = try! AVAudioPlayer(contentsOf: url)
            
            audioPlayer!.play()
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playback)
        }
        
        
        animationView = .init(name: "55861-confetti")
        
        animationView!.frame = view.bounds
        
        animationView!.contentMode = .scaleAspectFit
        
        animationView!.animationSpeed = 1
        
        view.addSubview(animationView!)
        
        
        animationView!.play()
        
        
        
        
        
    }
    
    
    @objc func didTapA(){
        buttonList.forEach { button in
            button?.isUserInteractionEnabled = false
        }
        showResults()
        
        if buttonA.titleLabel?.text == String(htmlString: currentQuestion?.correct_answer ?? ""){
            buttonA.backgroundColor = UIColor(named: "Correct")
            playAnimation()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) { [self] in
                updatePoints()
                if !questions.isEmpty{
                    refreshData()
                }
                
            }
            
        } else{
            
            buttonA.backgroundColor = UIColor(named: "Incorrect")
            highlightCorrectAnswer()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) { [self] in
                
                if !questions.isEmpty{
                    refreshData()
                }            }
            
        }
        
        
        
        
        
        
    }
    
    @objc func didTapB(){
        
        buttonList.forEach { button in
            button?.isUserInteractionEnabled = false
        }
        showResults()
        
        
        if buttonB.titleLabel?.text == String(htmlString: currentQuestion?.correct_answer ?? ""){
            buttonB.backgroundColor = UIColor(named: "Correct")
            playAnimation()
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) { [self] in
                updatePoints()
                if !questions.isEmpty{
                    refreshData()
                }
            }
            
        } else{
            
            buttonB.backgroundColor = UIColor(named: "Incorrect")
            highlightCorrectAnswer()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) { [self] in
                
                if !questions.isEmpty{
                    refreshData()
                }            }
            
        }
        
    }
    
    @objc func didTapC(){
        buttonList.forEach { button in
            button?.isUserInteractionEnabled = false
        }
        
        showResults()
        
        if buttonC.titleLabel?.text == String(htmlString: currentQuestion?.correct_answer ?? ""){
            
            buttonC.backgroundColor = UIColor(named: "Correct")
            playAnimation()
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) { [self] in
                updatePoints()
                if !questions.isEmpty{
                    refreshData()
                }            }
            
        } else{
            
            buttonC.backgroundColor = UIColor(named: "Incorrect")
            highlightCorrectAnswer()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) { [self] in
                
                if !questions.isEmpty{
                    refreshData()
                }            }
            
        }
    }
    
    @objc func didTapD(){
        buttonList.forEach { button in
            button?.isUserInteractionEnabled = false
        }
        
        showResults()
        
        
        if buttonD.titleLabel?.text == String(htmlString: currentQuestion?.correct_answer ?? ""){
            
            buttonD.backgroundColor = UIColor(named: "Correct")
            playAnimation()
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) { [self] in
                
                updatePoints()
                if !questions.isEmpty{
                    refreshData()
                }            }
            
        }
        else{
            
            buttonD.backgroundColor = UIColor(named: "Incorrect")
            highlightCorrectAnswer()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) { [self] in
                if !questions.isEmpty{
                    refreshData()
                }            }
            
        }
    }
    
    
    
}
