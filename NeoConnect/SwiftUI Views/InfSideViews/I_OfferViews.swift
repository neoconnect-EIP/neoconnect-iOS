//
//  I_OfferViews.swift
//  NeoConnect
//
//  Created by Ilan on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire
import Combine
import KingfisherSwiftUI

class DetailOfferHostingController: UIHostingController<DetailOffer2> {
    var selectedOffer : I_Offer!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DetailOffer2(selectedOffer: selectedOffer, date: ""))
    }
}

struct DetailOffer2: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var rating = 0
    var selectedOffer : I_Offer
    var date : String
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .center, spacing: 20.0) {
                HStack{
                    Button(action: { self.shareOffer()})
                    {
                        Image(systemName: "square.and.arrow.up")
                            
                            .padding(.leading, 270.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }.padding(.horizontal)
                    Button(action: { self.reportOffer()})
                    {
                        Image(systemName: "flag")
                            
                            .foregroundColor(.red)                    }
                }.padding(.horizontal)
                Text(String(selectedOffer.title )).foregroundColor(Color.white).font(.custom("Raleway", size: 20))
                if (selectedOffer.images.isEmpty) {
                    Image("placeholder-image").resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                    
                }
                if (selectedOffer.images.count > 2) {
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(selectedOffer.images, id: \.self) { img in
                                Image(uiImage: img).resizable().frame(width: 100, height: 100)
                                    .clipShape(Circle()).clipped().shadow(radius: 3)
                            }
                        }
                    }.padding()
                }
                if (selectedOffer.images.count == 2) {
                    HStack{
                        Image(uiImage: selectedOffer.images[0]).renderingMode(.original).resizable().frame(width: 100, height: 100)
                            .clipShape(Circle()).clipped().shadow(radius: 3)
                        Image(uiImage: selectedOffer.images[0]).renderingMode(.original).resizable().frame(width: 100, height: 100)
                            .clipShape(Circle()).clipped().shadow(radius: 3)
                    }
                }
                else {
                    Image(uiImage: selectedOffer.images[0]).renderingMode(.original).resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                }
                
                Text(String(selectedOffer.brand )).foregroundColor(Color.white).font(.custom("Raleway", size: 16))
                Divider()
                    .frame(width: 75.0, height: 1.0)
                    .background(Color(hex: "445173"))
                Group{
                    HStack{
                        if (selectedOffer.subject == "Cosmétique" || selectedOffer.subject == "Mode")
                        {
                            Text("Sexe:").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                            if (selectedOffer.sex.isEmpty)
                            {
                                Text("Unisexe").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                            }
                            else{
                                Text(selectedOffer.sex ).foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                            }
                        }
                    }
                    
                    Text(String(selectedOffer.description )).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.vertical)
                    
                    Divider()
                        .frame(width: 245.0, height: 1.0)
                        .background(Color(hex: "445173"))
                    Text(String(selectedOffer.subject )).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Divider()
                        .frame(width: 75, height: 1.0)
                        .background(Color(hex: "445173"))
                }
                HStack{
                    if (selectedOffer.status == "accepted") {
                        NavigationLink(destination: ShareOfferView2(selectedOffer: selectedOffer, facebook: "", twitter: "", instagram: "", pinterest: "", twitch: "", youtube: "", tiktok: "")) {
                            ZStack
                            {
                                Image("login").foregroundColor(Color(hex: "445173"))

                                Text("Conclure").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }
                        }
                    }
                    else if (selectedOffer.status == "pending") {
                        Button(action: {removeApply2(offer: self.selectedOffer)
                            self.showingAlert = true
                        }) {
                            ZStack
                            {
                                Image("login").foregroundColor(Color(hex: "445173"))

                                    .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                Text("Annuler").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }

                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Annuler ma candidature"), message: Text("Vous avez annulé votre candidature."), dismissButton: .default(Text("Ok")))
                        }
                    }
                    else
                    {
                        Button(action: {postulate2(offer: self.selectedOffer)
                            self.showingAlert = true
                        }) {
                            ZStack
                            {
                                Image("login")
                                    .foregroundColor(Color(hex: "445173"))
                                Text("Postuler").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }                  }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Postuler à une offre"), message: Text("Vous avez postulé à cette offre."), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
                
            }.padding(.top,50)
            
        } .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Text("Retour")
                                    }
                                })
    }
    func shareOffer(){ // Partage d'une offre
        
        let alertController = UIAlertController(title: "Partager une offre", message: "Veuillez indiquer l'adresse mail de l'utilisateur", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Email"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let email = alertController.textFields![0].text
            let map = ["email": email!]
            AF.request(url+"offer/share/" + String(self.selectedOffer.id),
                       method: .post,
                       parameters: map as Parameters,
                       encoding: URLEncoding.default,headers: _headers).response { response in
                        debugPrint(response)
                       }
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }
    func reportOffer() { // Signalement d'une offre
        
        let alertController = UIAlertController(title: "Signaler une offre", message: "Veuillez indiquer le motif de votre signalement", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Motif"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let motif = alertController.textFields![0].text!
            
            let map = [ "offerName" : selectedOffer.title,
                        "message": motif,
                        "subject": "Offre"]
            AF.request(url+"offer/report/" + String(selectedOffer.id),
                       method: .post,
                       parameters: map as Parameters,
                       encoding: URLEncoding.default,headers: _headers).response { response in
                        debugPrint(response)
                       }
            
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }
}

// Page Partage des publications
struct ShareOfferView2: View {
    @Environment(\.presentationMode) var presentationMode
    var selectedOffer : I_Offer
    @State private var showingAlert = false
    @State private var validator = true
    @State var facebook : String
    @State var twitter : String
    @State var instagram : String
    @State var pinterest : String
    @State var twitch : String
    @State var youtube : String
    @State var tiktok : String
    
    
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text("Partage des publications").foregroundColor(Color.white).font(.custom("Raleway", size: 20))
                VStack{
                    
                    Group {
                        CustomTextField(
                            placeholder: Text("Facebook").foregroundColor(.black),
                            text: $facebook
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifFb(facebook: facebook, validator: validator) .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Twitter").foregroundColor(.black),
                            text: $twitter
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifTwitter(twitter: twitter) .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Instagram").foregroundColor(.black),
                            text: $instagram
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifInsta(instagram: instagram) .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Pinterest").foregroundColor(.black),
                            text: $pinterest
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifPinterest(pinterest: pinterest).foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Twitch").foregroundColor(.black),
                            text: $twitch
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifTwitch(twitch: twitch).foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    CustomTextField(
                        placeholder: Text("Youtube").foregroundColor(.black),
                        text: $youtube
                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Divider()
                    verifYtb(youtube: youtube).foregroundColor(Color.red)
                        .font(.custom("Raleway", size: 15))
                    CustomTextField(
                        placeholder: Text("TikTok").foregroundColor(.black),
                        text: $tiktok
                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                }
                Divider()
                    verifTikTok(tiktok: tiktok)
                        .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    .frame(width: 300.0, height: 1.0)
//                    .background(Color(hex:"445173"))
                if (!self.facebook.isEmpty || !self.twitter.isEmpty ||
                        !self.instagram.isEmpty ||
                        !self.pinterest.isEmpty ||
                        !self.twitch.isEmpty ||
                        !self.youtube.isEmpty ||
                        !self.tiktok.isEmpty)
                {
                    Button(action:{
                        let _headers: HTTPHeaders = [
                            "Authorization": "Bearer " + accessToken  ]
                        let map = ["facebook": self.facebook,
                                   "twitter": self.twitter,
                                   "instagram": self.instagram,
                                   "pinterest": self.pinterest,
                                   "twitch": self.twitch,
                                   "youtube": self.youtube,
                                   "tiktok": self.tiktok]
                        AF.request(url+"offer/sharePublication/" + String(self.selectedOffer.id),
                                   method: .post,
                                   parameters: map,
                                   encoding: URLEncoding.default,headers: _headers).response { response in
                                    debugPrint(response)
                                   }
                        self.showingAlert = true
                        
                    }) {
                        Image("icons8-envoi-de-courriel-24")
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        
                    }
                    .frame(width: 300.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Partager les publications"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
                        
                    }
                }
                else{
                    Text("Veuillez remplir au moins un champ")
                        .foregroundColor(Color.red)
                        .padding(.top)
                        .font(.custom("Raleway", size: 15))
                }
            }
            
            .padding(20.0)
            
            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Text("Retour")
                                    }
                                })
    }
    
    // Vérifications des liens
    
    func verifFb(facebook : String, validator: Bool) -> Text {
        if (facebook.hasPrefix("https://www.facebook.com/") || facebook.hasPrefix("facebook.com") || facebook.isEmpty)
        {
            return Text("")
        }
            self.validator = false
            return Text("Compte Facebook invalide")
    }
    func verifTwitter(twitter : String) -> Text {
        if (twitter.hasPrefix("https://www.twitter.com/") || twitter.hasPrefix("twitter.com") || twitter.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Twitter invalide")
    }
    
    func verifInsta(instagram : String) -> Text {
        if (instagram.hasPrefix("https://www.instagram.com/") || instagram.hasPrefix("instagram.com") || instagram.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Instagram invalide")
    }
    
    func verifPinterest(pinterest : String) -> Text {
        if (pinterest.hasPrefix("https://www.pinterest.fr/") || pinterest.hasPrefix("pinterest.fr") || pinterest.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Pinterest invalide")
    }
    
    func verifTwitch(twitch : String) -> Text {
        if (twitch.hasPrefix("https://www.twitch.tv/") || twitch.hasPrefix("twitch.tv") || twitch.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Twitch invalide")
    }
    
    func verifYtb(youtube : String) -> Text {
        if (youtube.hasPrefix("https://www.youtube.com/") || youtube.hasPrefix("youtube.com") || youtube.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Youtube invalide")
    }
    
    func verifTikTok(tiktok : String) -> Text {
        if (tiktok.hasPrefix("https://www.tiktok.com/") || tiktok.hasPrefix("tiktok.com") || tiktok.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Tiktok invalide")
    }
    
    
}

// Postuler à une offre

func postulate2(offer : I_Offer) {
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request(url+"offer/apply/" + String(offer.id), method: .put, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        print(response)
    }
}

// Annuler la candidature à une offre
func removeApply2(offer : I_Offer) {
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request(url+"offer/noapply/" + String(offer.id), method: .delete, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        print(response)
    }
}
