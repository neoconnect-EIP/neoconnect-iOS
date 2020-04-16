//
//  B_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_SearchViewController: UIViewController {

        @IBOutlet weak var shopFoundView: shopFound!
        @IBOutlet weak var messageTextField: UILabel!
        let searchBar = UISearchBar()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            shopFoundView.isHidden = true
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

    extension B_SearchViewController : UISearchBarDelegate {
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            search(shouldShow: false)
            shopFoundView.isHidden = true
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if (searchBar.text == "Bibi") {
                shopFoundView.isHidden = false
                shopFoundView.pseudoTextField.text = "Nike"
                shopFoundView.emailTextField.text = "Nike Email"
                shopFoundView.fullnameTextField.text = "Nike full name"
                shopFoundView.postalTextField.text = "12345"
                shopFoundView.cityTextField.text = "New York"
                shopFoundView.phoneTextField.text = "0612345678"
                shopFoundView.societyTextField.text = "Nike"
                shopFoundView.functionTextField.text = "function"
                shopFoundView.themeTextField.text = "theme"
                messageTextField.text = "Veuillez entrer votre recherche"
            } else {
                messageTextField.text = "Aucune marque trouvées, veuillez réessayer."
            }
        }
    }
