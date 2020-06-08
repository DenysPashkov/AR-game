//
//  OnboardingScreenViewController.swift
//  AR try 0.1
//
//  Created by Cihan Hasanoglu on 24.11.19.
//  Copyright © 2019 denys pashkov. All rights reserved.
//

import UIKit

class OnboardingScreenViewController: UIViewController {

    @IBOutlet weak var infoPanelView: UIImageView!
    
   
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        infoPanelView.image = UIImage(named: "infoPanel")
            
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @IBAction func continueToNext(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toMainSegue", sender: sender)
        UserDefaults.standard.set("opened", forKey: "launchedFirstTime")
    }
}
