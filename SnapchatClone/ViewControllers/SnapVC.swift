//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Berk Gülşen on 11.10.2023.
//

import UIKit

class SnapVC: UIViewController {
    
    var selectedSnap: Snap?
    var selectedTime: Int?
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let time = selectedTime {
            timeLabel.text = "Time Left: \(time)"
        }
    }
    

}
