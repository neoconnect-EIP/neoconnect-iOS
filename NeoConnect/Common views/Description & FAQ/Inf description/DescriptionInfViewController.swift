//
//  DescriptionViewController.swift
//  NeoConnect
//
//  Created by EIP on 15/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class DescriptionInfViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[DescriptionInfSlide] = []
 
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "I_Register_and_Connection", bundle: nil)
        let InfSide = storyBoard.instantiateViewController(withIdentifier: "I_Register")
        self.show(InfSide, sender: nil)
    }
    
    func createSlides() -> [DescriptionInfSlide] {
        
        let slide1:DescriptionInfSlide = Bundle.main.loadNibNamed("DescriptionInfSlide", owner: self, options: nil)?.first as! DescriptionInfSlide
        slide1.imageView.image = UIImage(named: "Chat - Inf")
        slide1.TitleLabelField.text = "Mise en relation avec des boutiques"
        slide1.DescriptionLabelField.text = "Créez des relations avec différentes boutiques pour de futurs partenariats"
    
        let slide2:DescriptionInfSlide = Bundle.main.loadNibNamed("DescriptionInfSlide", owner: self, options: nil)?.first as! DescriptionInfSlide
        slide2.imageView.image = UIImage(named: "Social share - Inf")
        slide2.TitleLabelField.text = "Publication du produit"
        slide2.DescriptionLabelField.text = "Recevez un produit d'une marque à partager sur vos réseaux"
    
        let slide3:DescriptionInfSlide = Bundle.main.loadNibNamed("DescriptionInfSlide", owner: self, options: nil)?.first as! DescriptionInfSlide
        slide3.imageView.image = UIImage(named: "Followers - Inf")
        slide3.TitleLabelField.text = "Faite de votre passion un métier"
        slide3.DescriptionLabelField.text = "Voyez votre nombre de followers augmenter avec un produit gratuit en plus!"
    
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [DescriptionInfSlide]) {
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
