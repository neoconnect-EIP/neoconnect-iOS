//
//  I_SponsorShipViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 22/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_UserSponsorshipViewController: UIViewController {

    @IBOutlet weak var userSponsorshipCode: UILabel!
    @IBOutlet weak var userSponsorshipCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatafromAPI()
    }
    
    func getDatafromAPI() {
        APIInfManager.sharedInstance.getInfo(onSuccess: { response in
            self.userSponsorshipCode.text = response["codeParrainage"] as? String
            let countParrainage = response["countParrainage"] as? Int
            countParrainage == 0 ? (self.userSponsorshipCount.text = "Vous n'avez encore parrainé personne") : (self.userSponsorshipCount.text = "Vous avez parrainé \(String(describing: countParrainage)) personne(s)")
        })
    }
}
