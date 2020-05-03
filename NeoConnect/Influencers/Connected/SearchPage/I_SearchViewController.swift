//
//  I_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class I_SearchViewController: UIViewController {
        
    @IBOutlet weak var userFoundView: userFound!
    @IBOutlet weak var messageTextField: UILabel!
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        userFoundView.isHidden = true
        configureSearchBar()
    }
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            searchBar.placeholder = "Veuillez entrer votre recherche ..."
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
            searchBar.text = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
}

extension I_SearchViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        userFoundView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text == "Bibi") {
            userFoundView.isHidden = false
            userFoundView.pseudoTextField.text = "Bibi"
            userFoundView.emailTextField.text = "Bibi Email"
            userFoundView.fullnameTextField.text = "Bibi full name"
            userFoundView.postalTextField.text = "12345"
            userFoundView.cityTextField.text = "Aubervilliers"
            userFoundView.phoneTextField.text = "0712345678"
            userFoundView.facebookTextField.text = "facebook"
            userFoundView.twitterTextField.text = "twitter"
            userFoundView.instagramTextField.text = "instagram"
            userFoundView.snapchatTextField.text = "snapchat"
            userFoundView.themeTextField.text = "theme"
            messageTextField.text = "Veuillez entrer votre recherche"
        } else {
            messageTextField.text = "Aucun utilisateur trouvé, veuillez réessayer."
        }
    }
}
