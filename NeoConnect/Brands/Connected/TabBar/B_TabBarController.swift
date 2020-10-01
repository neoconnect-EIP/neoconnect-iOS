//
//  B_TabBarController.swift
//  NeoConnect
//
//  Created by EIP on 25/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class B_TabBarController: UITabBarController, UITabBarControllerDelegate {

    var homeViewController: UIViewController!
    var searchViewController: UINavigationController!
    var addOfferViewController: AddOfferViewController!
    var chatViewController: UINavigationController!
    var profileViewController: UINavigationController!

    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self

        let homeStoryboard = UIStoryboard(name: "B_Home", bundle: nil)
        let searchStoryboard = UIStoryboard(name: "B_Search", bundle: nil)
        let chatStoryboard = UIStoryboard(name: "B_Chat", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "B_Profile", bundle: nil)

        homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "B_Home")
        searchViewController = searchStoryboard.instantiateViewController(withIdentifier: "B_SearchNav") as? UINavigationController
        addOfferViewController = AddOfferViewController()
        chatViewController = chatStoryboard.instantiateViewController(withIdentifier: "B_ChatNav") as? UINavigationController
        profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "B_ProfileNav") as? UINavigationController
        
        homeViewController.tabBarItem.image = UIImage(named: "Home Icon")?.withRenderingMode(.alwaysOriginal)
        homeViewController.tabBarItem.selectedImage = UIImage(named: "Home Icon Selected")?.withRenderingMode(.alwaysOriginal)
        searchViewController.tabBarItem.image = UIImage(named: "Search Icon")?.withRenderingMode(.alwaysOriginal)
        searchViewController.tabBarItem.selectedImage = UIImage(named: "Search Icon Selected")?.withRenderingMode(.alwaysOriginal)
        addOfferViewController.tabBarItem.image = UIImage(named: "Add Offer Icon")?.withRenderingMode(.alwaysOriginal)
        addOfferViewController.tabBarItem.selectedImage = UIImage(named: "Add Offer Icon Selected")?.withRenderingMode(.alwaysOriginal)
        chatViewController.tabBarItem.image = UIImage(named: "Messages Icon")?.withRenderingMode(.alwaysOriginal)
        chatViewController.tabBarItem.selectedImage = UIImage(named: "Messages Icon Selected")?.withRenderingMode(.alwaysOriginal)
        profileViewController.tabBarItem.image = UIImage(named: "Profile Icon")?.withRenderingMode(.alwaysOriginal)
        profileViewController.tabBarItem.selectedImage = UIImage(named: "Profile Icon Selected")?.withRenderingMode(.alwaysOriginal)
        viewControllers = [homeViewController, searchViewController, addOfferViewController, chatViewController, profileViewController]
        for tabBarItem in tabBar.items! {
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isModalView = viewController is AddOfferViewController
        
        if isModalView {
            let addOfferStoryboard = UIStoryboard(name: "AddOffer", bundle: nil)
            let vc = addOfferStoryboard.instantiateViewController(withIdentifier: "B_AddOffer") as! AddOfferViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
}
