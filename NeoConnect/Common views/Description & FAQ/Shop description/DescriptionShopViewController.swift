//
//  DescriptionShopViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class DescriptionShopViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
       
    var slides:[DescriptionShopSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        slides = createSlides()
        setupSlideScrollView(slides: slides)
       
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
   
    @IBAction func loginButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
        let InfSide = storyBoard.instantiateViewController(withIdentifier: "B_Register")
        self.show(InfSide, sender: nil)
    }
   
    func createSlides() -> [DescriptionShopSlide] {
       
        let slide1:DescriptionShopSlide = Bundle.main.loadNibNamed("DescriptionShopSlide", owner: self, options: nil)?.first as! DescriptionShopSlide
        slide1.imageView.image = UIImage(named: "Chat - Shop")
        slide1.TitleLabelField.text = "Mise en relation avec des influenceurs"
        slide1.DescriptionLabelField.text = "Créez des relations avec des influenceurs pour de futurs partenariats"
   
        let slide2:DescriptionShopSlide = Bundle.main.loadNibNamed("DescriptionShopSlide", owner: self, options: nil)?.first as! DescriptionShopSlide
        slide2.imageView.image = UIImage(named: "Delivery - Shop")
        slide2.TitleLabelField.text = "Livraison du produit"
        slide2.DescriptionLabelField.text = "Livrez un produit à promouvoir à un influenceur"
   
        let slide3:DescriptionShopSlide = Bundle.main.loadNibNamed("DescriptionShopSlide", owner: self, options: nil)?.first as! DescriptionShopSlide
        slide3.imageView.image = UIImage(named: "Queue - Shop")
        slide3.TitleLabelField.text = "Devenez une marque incontournable"
        slide3.DescriptionLabelField.text = "Voyez votre nombre de clients augmenter grâce aux influenceurs!"
   
        return [slide1, slide2, slide3]
    }
   
    func setupSlideScrollView(slides : [DescriptionShopSlide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
       
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        scrollView.contentOffset.y = 0
    }
}
