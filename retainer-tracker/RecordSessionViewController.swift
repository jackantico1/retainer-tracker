//
//  RecordSessionViewController.swift
//  retainer-tracker
//
//  Created by Jack Antico on 3/22/20.
//  Copyright © 2020 Jack Antico. All rights reserved.
//

import UIKit
import Firebase

class RecordSessionViewController: UIViewController {
    
    
    @IBOutlet weak var hoursWorn: UITextField!
    @IBOutlet weak var wasTakenOut: UISegmentedControl!
    @IBOutlet weak var painLevel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func recordSessionPressed(_ sender: UIButton) {
        let hoursWornStr = hoursWorn.text ?? ""
        if (hoursWornStr.isInt) {
            showErrorMessage(messageTitle: "Error", messageText: "Please enter an integer in the first field.")
            return
        }
        
        let uid = UIDevice.current.identifierForVendor!.uuidString
        getNumOfSessions { (numOfPosts) -> () in
            let date = "\(Date())".dropLast(15)
            let hoursWorn = Int(hoursWornStr) ?? 0
            let takenOut = self.wasTakenOut.selectedSegmentIndex == 0 ? false : true
            let levelOfPain = self.painLevel.selectedSegmentIndex
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("sessions/\(uid)/post\(numOfPosts)").setValue(["date": date, "hoursWorn": hoursWorn, "takenOut": takenOut, "levelOfPain": levelOfPain])
            self.performSegue(withIdentifier: "segueFromRecordSessionToHome", sender: self)
        }
    }

}

extension String {
    var isInt: Bool {
        return Int(self) == nil
    }
}
