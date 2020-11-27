//
//  FiltersViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
    func filterSelected(param: String, filter: String)
}

class FiltersViewController: UIViewController, FiltersTableViewControllerDelegate {
    
    var tableViewController: FiltersTableViewController?
    var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        tableViewController = self.children[0] as? FiltersTableViewController
        tableViewController?.delegate = self
        super.viewDidLoad()
    }
    
    func filterSelected(param: String, filter: String) {
        delegate?.filterSelected(param: param, filter: filter)
        navigationController?.popToRootViewController(animated: true)
    }
}
