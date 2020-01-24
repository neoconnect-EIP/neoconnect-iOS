//
//  I_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class I_SearchViewController: UIViewController {
        
    @IBOutlet weak var searchButton: UIBarButtonItem!
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
}
