//
//  FAQViewController.swift
//  NeoConnect
//
//  Created by EIP on 31/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = [FAQItem(question: "Qu'est-ce que Neoconnect ?", answer: "Neoconnect est une plateforme de mise en relation entre les influenceurs et les marques.Nous privilégions une évolution coopérative pour nos utilisateurs. Le principe sera qu’un influenceur aura accès à une liste de d’offres auxquelles il pourra postuler. Si la marque accepte sa candidature, elle devra lui envoyer le produit que l’influenceur devra partager sur ses réseaux sociaux. "),
                     FAQItem(question: "L’application est-elle gratuite ?", answer: "Oui, l'application Neoconnect est entièrement gratuite pour les influenceurs mais un abonnement sera obligatoire pour les marques. "),
                     FAQItem(question: "Pourquoi utiliser Neoconnect ?", answer: "En tant qu’influenceur, utiliser Neoconnect vous permettra de gagner en visibilité et donc gagner des abonnés. De plus vous gagnerez un produit qui devra être partager sur vos réseaux sociaux. En tant que marque, utiliser Neoconnect vous permettra de gagner en visibilité et donc augmenter votre clientèles sans passer par une agence de communication."),
                     FAQItem(question: "Pourquoi nous et pas un autre service qui nous ressemble ?", answer: "Avec nous, peu importe votre domaine, que ce soit High Tech, Mode, Cosmétique, Sport, Jeu Vidéo ou Food, vous trouverez des offres ou des influenceurs qui vous conviendront."),
                     FAQItem(question: "Quels langues seront disponibles ?", answer: "L’application et le site seront disponibles uniquement en français pour commencer. "),
                     FAQItem(question: "Sur quels appareils est disponible l’application ? ", answer: "Pour l’application mobile Android, il faut un appareil avec Android 8.0 minimum. Pour l’application mobile iOS, il faut un appareil avec iOS 13 minimum")]
        let faqView = FAQView(frame: view.frame, title: "FAQ", items: items)
        faqView.titleLabelTextFont = UIFont(name: "Raleway-medium", size: 20)
        faqView.titleLabelTextColor = UIColor.white
        faqView.questionTextFont = UIFont(name: "Raleway-medium", size: 15)
        faqView.questionTextColor = UIColor.white
        faqView.answerTextFont = UIFont(name: "Raleway-regular", size: 13)
        faqView.answerTextColor = UIColor.white
        faqView.backgroundColor = .clear
        faqView.cellBackgroundColor = .clear
        faqView.separatorColor = .clear
        faqView.viewBackgroundColor = .clear
        view.addSubview(faqView)
    }
}
