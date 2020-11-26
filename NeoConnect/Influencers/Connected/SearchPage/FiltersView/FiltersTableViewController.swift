//
//  FiltersTableViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol FiltersTableViewControllerDelegate {
    func filterSelected(param: String, filter: String)
}

class FiltersTableViewController: UITableViewController, ThemeFilterViewControllerDelegate {
    
    var delegate: FiltersTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getThemeSegue" {
            let themeVC: ThemeFilterViewController = segue.destination as! ThemeFilterViewController
            themeVC.delegate = self
        }
    }
    
    func themeSelected(param: String, filter: String) {
        if let delegate = delegate {
            delegate.filterSelected(param: param, filter: filter)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let delegate = delegate {
            switch indexPath.row {
            case 0:
                break
            case 1:
                delegate.filterSelected(param: "order", filter: "asc")
            default:
                delegate.filterSelected(param: "order", filter: "desc")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
