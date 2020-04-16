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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func description_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Description", bundle: nil)
        let View = storyBoard.instantiateViewController(withIdentifier: "Description")
        self.show(View, sender: nil)
    }
    
    @IBAction func BrandSide_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
        let BrandSide = storyBoard.instantiateViewController(withIdentifier: "B_NavController")
        BrandSide.modalPresentationStyle = .fullScreen

        self.dismiss(animated: true, completion: {
            self.present(BrandSide, animated: true, completion: nil)
        })
    }
    
    @IBAction func InfSide_ButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "I_Register_and_Connection", bundle: nil)
        let InfSide = storyBoard.instantiateViewController(withIdentifier: "I_NavController")
        InfSide.modalPresentationStyle = .fullScreen

        self.dismiss(animated: true, completion: {
            self.present(InfSide, animated: true, completion: nil)
        })
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
