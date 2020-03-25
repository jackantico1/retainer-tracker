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
    @IBOutlet weak var lastSessionDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setTotalSessions()
        setLastSessionDate()
    }
    
    func setHoursWorn() {
        
    }
    
    func setLastSessionDate() {
        let uid = UIDevice.current.identifierForVendor!.uuidString
        getNumOfSessions { (numOfSessions) in
            self.getDataSnapshot(path: "sessions/\(uid)/post\(numOfSessions - 1)") { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let lastDate = value?["date"] as? String ?? "No Data"
                self.lastSessionDate.text = "Last Session Date: \(lastDate)"
            }
        }
    }
    
    func setTotalSessions() {
        getNumOfSessions { (numOfSessions) in
            self.totalNumOfSessions.text = "Total Number of Sessions: \(numOfSessions)"
        }
    }

}
