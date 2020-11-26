//
//  ThemeFilterTableViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol ThemeFilterTableViewControllerDelegate {
    func themeSelected(param: String, filter: String)
}

class ThemeFilterTableViewController: UITableViewController {
    
    var delegate: ThemeFilterTableViewControllerDelegate?
    var theme = "productSubject"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let delegate = delegate {
            switch indexPath.row {
            case 0:
                delegate.themeSelected(param: theme, filter: "Mode")
            case 1:
                delegate.themeSelected(param: theme, filter: "High tech")
            case 2:
                delegate.themeSelected(param: theme, filter: "Sport/Fitness")
            case 3:
                delegate.themeSelected(param: theme, filter: "Nourriture")
            case 4:
                delegate.themeSelected(param: theme, filter: "Jeux Vidéo")
            default:
                delegate.themeSelected(param: theme, filter: "Cosmétique")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
