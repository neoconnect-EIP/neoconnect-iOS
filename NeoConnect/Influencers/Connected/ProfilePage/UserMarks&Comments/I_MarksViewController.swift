//
//  I_MarksViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_MarksViewController: UIViewController {
    
    @IBOutlet weak var averageNoteLabelField: UILabel!
    @IBOutlet weak var averageDescLabelField: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headers: HTTPHeaders = [
                   "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
                   "Content-Type": "application/x-www-form-urlencoded"
               ]

        AF.request("http://168.63.65.106:8080/inf/me", headers: headers).responseJSON { response in
            switch response.result {

            case .success(let JSON):

                let response = JSON as! NSDictionary
                print(response)

                if (response.object(forKey: "average")! as? Double == nil) {
                    self.averageNoteLabelField.text = "0"
                    self.averageDescLabelField.text = "Vous n'avez pas encore été noté"
                } else {
                    self.averageNoteLabelField.text = String(format:"%.1f", response.object(forKey: "average")! as! Double)
                    self.averageNoteLabelField.text! += "/5"
                }

            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
}
