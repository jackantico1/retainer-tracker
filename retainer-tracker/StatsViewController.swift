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
    
    func setLastSessionDate() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        let numOfPosts = UserDefaults.standard.integer(forKey: "numOfSessions")
        ref.child("sessions/\(uid)/post\(numOfPosts)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let lastDate = value?["date"] as? String ?? "No Data"
            self.lastSessionDate.text = "Last Session Date: \(lastDate)"
        }) { (error) in
            self.showErrorMessage(messageTitle: "Error:", messageText: error.localizedDescription)
        }
    }
    
    func setTotalSessions() {
        getNumOfSessions { (numOfSessions) in
            self.totalNumOfSessions.text = "Total Number of Sessions: \(numOfSessions)"
        }
    }

}
