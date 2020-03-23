//
//  StatsViewController.swift
//  retainer-tracker
//
//  Created by Jack Antico on 3/23/20.
//  Copyright © 2020 Jack Antico. All rights reserved.
//

import UIKit
import Firebase

class StatsViewController: UIViewController {

    
    @IBOutlet weak var totalNumOfSessions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setTotalSessions()
    }
    
    func setLastSessionDate() {
        
    }
    
    func setTotalSessions() {
        let totalSessionsNum = UserDefaults.standard.integer(forKey: "numOfSessions")
        self.totalNumOfSessions.text = "        Total Number of Sessions:  \(totalSessionsNum)"
    }

}
