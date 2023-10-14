//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Berk Gülşen on 11.10.2023.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {
    
    var selectedSnap: Snap?
    var inputArray = [SDWebImageSource]()
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let snap = selectedSnap {
            for imageUrl in snap.imageUrlArray {
                inputArray.append(SDWebImageSource(urlString: imageUrl)!)
            }
        }
        
        let imageSlideshow = ImageSlideshow(frame: CGRect(x: 10, y: 70, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.70))
        imageSlideshow.backgroundColor = UIColor.white
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
        pageIndicator.pageIndicatorTintColor = UIColor.black
        imageSlideshow.pageIndicator = pageIndicator
        
        imageSlideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        imageSlideshow.setImageInputs(inputArray)
        self.view.addSubview(imageSlideshow)
        self.view.addSubview(timeLabel)
    }
    

}
