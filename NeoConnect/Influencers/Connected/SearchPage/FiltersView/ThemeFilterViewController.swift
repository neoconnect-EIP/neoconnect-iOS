//
//  FilterThemeViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol ThemeFilterViewControllerDelegate {
    func themeSelected(param: String, filter: String)
}

class ThemeFilterViewController: UIViewController, ThemeFilterTableViewControllerDelegate {
    
    var tableViewController: ThemeFilterTableViewController?
    var delegate: ThemeFilterViewControllerDelegate?

    override func viewDidLoad() {
        tableViewController = self.children[0] as? ThemeFilterTableViewController
        tableViewController?.delegate = self
        super.viewDidLoad()
    }
    
    func themeSelected(param: String, filter: String) {
        if filter != "Mode" || filter != "Cosmétique" {
            delegate?.themeSelected(param: param, filter: filter)
            navigationController?.popViewController(animated: true)
        }
    }
}
