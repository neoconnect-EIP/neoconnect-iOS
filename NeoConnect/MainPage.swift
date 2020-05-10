//
//  ViewController.swift
//  NeoConnect
//
//  Created by EIP on 29/05/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Foundation

class MainPage: UIViewController {

    @IBOutlet weak var InfView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func BrandSide_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DescriptionShop", bundle: nil)
        let View = storyBoard.instantiateViewController(withIdentifier: "DescriptionShop")
        self.show(View, sender: nil)
    }
    
    @IBAction func InfSide_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DescriptionInf", bundle: nil)
        let View = storyBoard.instantiateViewController(withIdentifier: "DescriptionInf")
        self.show(View, sender: nil)
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


extension Array {
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }

}
