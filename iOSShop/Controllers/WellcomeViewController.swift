//
//  ViewController.swift
//  iOSShop
//
//  Created by Adnann Muratovic on 03.11.21.
//

import UIKit

class WellcomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.layer.cornerRadius = 20
            continueButton.layer.borderColor = UIColor.white.cgColor
            continueButton.layer.borderWidth = 2
        }
    }
    
    
    // View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

