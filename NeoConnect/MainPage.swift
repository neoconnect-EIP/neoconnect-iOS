//
//  ViewController.swift
//  NeoConnect
//
//  Created by EIP on 29/05/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class MainPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "YassChen")!)
    }

    @IBAction func BrandSide_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
        let BrandSide = storyBoard.instantiateViewController(withIdentifier: "B_NavController")
        self.present(BrandSide, animated: true, completion: nil)
    }
    @IBAction func InfSide_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "I_Register_and_Connection", bundle: nil)
        let InfSide = storyBoard.instantiateViewController(withIdentifier: "I_NavController")
        self.present(InfSide, animated: true, completion: nil)
    }
}

