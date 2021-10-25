//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Khalil Panahi
//

import CLTypingLabel
import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var titleLabel: CLTypingLabel!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //to hide the navigation bar at home screen
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //to active navigation bar right before leaving the page
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = K.title
    }
}
