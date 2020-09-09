//
//  I_TabBarController.swift
//  NeoConnect
//
//  Created by EIP on 28/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var homeViewController: UIViewController!
    var searchViewController: UINavigationController!
    var chatViewController: UINavigationController!
    var profileViewController: UINavigationController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        let homeStoryboard = UIStoryboard(name: "I_Home", bundle: nil)
        let searchStoryboard = UIStoryboard(name: "I_Search", bundle: nil)
        let chatStoryboard = UIStoryboard(name: "I_Chat", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "I_Profile", bundle: nil)
        
        homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "I_Home")
        searchViewController = (searchStoryboard.instantiateViewController(withIdentifier: "I_SearchNav") as! UINavigationController)
        chatViewController = (chatStoryboard.instantiateViewController(withIdentifier: "I_ChatNav") as! UINavigationController)
        profileViewController = (profileStoryboard.instantiateViewController(withIdentifier: "I_ProfileNav") as! UINavigationController)
        
        homeViewController.tabBarItem.image = UIImage(named: "Home Icon")?.withRenderingMode(.alwaysOriginal)
        homeViewController.tabBarItem.selectedImage = UIImage(named: "Home Icon Selected")?.withRenderingMode(.alwaysOriginal)
        searchViewController.tabBarItem.image = UIImage(named: "Search Icon")?.withRenderingMode(.alwaysOriginal)
        searchViewController.tabBarItem.selectedImage = UIImage(named: "Search Icon Selected")?.withRenderingMode(.alwaysOriginal)
        chatViewController.tabBarItem.image = UIImage(named: "Messages Icon")?.withRenderingMode(.alwaysOriginal)
        chatViewController.tabBarItem.selectedImage = UIImage(named: "Messages Icon Selected")?.withRenderingMode(.alwaysOriginal)
        profileViewController.tabBarItem.image = UIImage(named: "Profile Icon")?.withRenderingMode(.alwaysOriginal)
        profileViewController.tabBarItem.selectedImage = UIImage(named: "Profile Icon Selected")?.withRenderingMode(.alwaysOriginal)
        viewControllers = [homeViewController, searchViewController, chatViewController, profileViewController]
        for tabBarItem in tabBar.items! {
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}

