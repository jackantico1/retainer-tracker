//
//  ViewController.swift
//  retainer-tracker
//
//  Created by Jack Antico on 3/22/20.
//  Copyright © 2020 Jack Antico. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIViewController {
    
    func getNumOfSessions(completion: @escaping (Int) -> ()) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        ref.child("sessions/\(uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            let numOfPost = Int(snapshot.childrenCount)
            completion(numOfPost)
        }) { (error) in
            self.showErrorMessage(messageTitle: "Error:", messageText: error.localizedDescription)
        }
    }
    
    func showErrorMessage(messageTitle: String, messageText: String) {
        let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
