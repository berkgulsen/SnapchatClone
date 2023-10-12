//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Berk Gülşen on 11.10.2023.
//

import UIKit
import Firebase

class FeedVC: UIViewController {
    
    let firestoreDatabase = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getUserInfo()
    }
    
    func getUserInfo() {
        firestoreDatabase.collection("userInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
