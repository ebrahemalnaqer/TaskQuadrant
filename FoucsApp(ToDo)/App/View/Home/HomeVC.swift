//
//  HomeVC.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Variables
    var currentScore: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.scoreLabel.text = "\(self.currentScore)"
                print("Score updated to \(self.currentScore)")
            }
        }
    }
    // MARK: - IBOutlet
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var DoFirstbtn: UIButton!
    @IBOutlet weak var Schedulebtn: UIButton!
    @IBOutlet weak var Delegatebtn: UIButton!
    @IBOutlet weak var DontDobtn: UIButton!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScoreAndCheckDate()
        self.title = "Home"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - IBActions
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        print("Button tapped")
        updateScoreNeeded()
    }
    @IBAction func DoFirstBtn(_ sender: Any) {
        let DoFirstBtn = DoFirstVC()
        nav(DoFirstBtn)
    }
    
    
    @IBAction func ScheduleBtn(_ sender: Any) {
        let ScheduleBtn = ScheduleVC()
        nav(ScheduleBtn)
    }
    
    
    @IBAction func DelegateBtn(_ sender: Any) {
        let DelegateBtn = DelegateVC()
       nav(DelegateBtn)
    }
    
    @IBAction func DontDoBtn(_ sender: Any) {
        let DontDoBtn = Dont_DoVC()
        nav(DontDoBtn)
    }
    
    // MARK: - Functions
    func loadScoreAndCheckDate() {
        let currentDate = Date()
        
        if let lastDate = UserDefaults.standard.object(forKey: "lastDate") as? Date {
            let calendar = Calendar.current
            if let dayDifference = calendar.dateComponents([.day], from: lastDate, to: currentDate).day, dayDifference >= 1 {
                currentScore = 0
            } else {
                currentScore = UserDefaults.standard.integer(forKey: "score")
            }
        } else {
            UserDefaults.standard.set(currentDate, forKey: "lastDate")
            UserDefaults.standard.set(currentScore, forKey: "score")
        }
    }

    

    func updateScoreNeeded() {
        let currentDate = Date()
        
        if let lastDate = UserDefaults.standard.object(forKey: "lastDate") as? Date {
            let calendar = Calendar.current
            
            if !currentDate.isSameDay(as: lastDate) {
                if let daysBetween = calendar.dateComponents([.day], from: lastDate, to: currentDate).day, daysBetween > 1 {
                    currentScore = 0
                }
                
                currentScore += 1
                UserDefaults.standard.set(currentDate, forKey: "lastDate")
                UserDefaults.standard.set(currentScore, forKey: "score")
                self.view.layoutIfNeeded()
            } else {
                print("Score can only be increased once per day.")
            }
        } else {
            UserDefaults.standard.set(currentDate, forKey: "lastDate")
            currentScore += 1
            UserDefaults.standard.set(currentScore, forKey: "score")
            self.view.layoutIfNeeded()
        }
    }
}
     
 extension Date {
     func isSameDay(as date: Date) -> Bool {
         let calendar = Calendar.current
         return calendar.isDate(self, inSameDayAs: date)
     }
 }
