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

    @IBOutlet weak var infButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    
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

extension Array {
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
