//
//  Test2.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 01/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire
import Combine
import KingfisherSwiftUI

// Annuler la candidature à une offre
func removeApply(offer : Offer2) {
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request(url+"offer/noapply/" + String(offer.id), method: .delete, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        print(response)
    }
}

// Offre détaillée (Mes offres)
struct DetailMyOfferInfSideView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var rating = 0
    var selectedOffer : Offer2
    var date : String
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .center, spacing: 20.0) {
                HStack{
                    Button(action: { self.shareOffer()})
                    {
                        Image(systemName: "square.and.arrow.up")
                            
                            .padding(.leading, 270.0)
                            .foregroundColor(.white)
                    }.padding(.horizontal)
                    Button(action: { self.reportOffer()})
                    {
                        Image(systemName: "flag")
                            
                            .foregroundColor(.red)                    }
                }.padding(.horizontal)
                Text(String(selectedOffer.productName ?? "Pas de nom")).foregroundColor(Color.white).font(.custom("Raleway", size: 20))
                if (selectedOffer.productImg!.isEmpty) {
                    Image("placeholder-image").resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                    
                }
                if (selectedOffer.productImg!.count > 2) {
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(selectedOffer.productImg!, id: \.self) { img in
                                KFImage(URL(string:img.imageData!)).resizable().frame(width: 100, height: 100)
                                    .clipShape(Circle()).clipped().shadow(radius: 3)
                            }
                        }
                    }.padding()
                }
                if (selectedOffer.productImg!.count == 2) {
                    HStack{
                        KFImage(URL(string:selectedOffer.productImg![0].imageData ?? " ")).renderingMode(.original).resizable().frame(width: 100, height: 100)
                            .clipShape(Circle()).clipped().shadow(radius: 3)
                        KFImage(URL(string:selectedOffer.productImg![1].imageData ?? " ")).renderingMode(.original).resizable().frame(width: 100, height: 100)
                            .clipShape(Circle()).clipped().shadow(radius: 3)
                    }
                }
                else
                {
                    KFImage(URL(string:selectedOffer.productImg![0].imageData ?? " ")).renderingMode(.original).resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                }
                Text(String(selectedOffer.brand ?? "Marque")).foregroundColor(Color.white).font(.custom("Raleway", size: 16))
                Divider()
                    .frame(width: 75.0, height: 1.0)
                    .background(Color(hex: "445173"))
                Group{
                    HStack {
                        if (selectedOffer.productSubject == "Cosmétique" || selectedOffer.productSubject == "Mode")
                        {
                            Text("Sexe:").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                            if (selectedOffer.productSex!.isEmpty)
                            {
                                Text("Unisexe").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                            }
                            else{
                                Text(selectedOffer.productSex ?? "Unisexe").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                            }
                        }
                    }
                    
                    Text(String(selectedOffer.productDesc ?? "Pas de description")).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.vertical)
                    
                    Divider()
                        .frame(width: 245.0, height: 1.0)
                        .background(Color(hex: "445173"))
                    Text(String(selectedOffer.productSubject ?? "Pas de thème renseigné")).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Divider()
                        .frame(width: 75, height: 1.0)
                        .background(Color(hex: "445173"))
                }
                HStack{
                    if (selectedOffer.status == "accepted") {
                        NavigationLink(destination: ShareOfferView(selectedOffer: selectedOffer, facebook: "", twitter: "", instagram: "", pinterest: "", twitch: "", youtube: "", tiktok: "")) {
                            ZStack
                            {
                                Image("login").foregroundColor(Color(hex: "445173"))
                                
                                Text("Conclure").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }
                        }
                    }
                    if (selectedOffer.status == "pending") {
                        Button(action: {removeApply(offer: self.selectedOffer)
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
    
    func reportOffer(){ // Signalement d'une offre
        
        let alertController = UIAlertController(title: "Signaler une offre", message: "Veuillez indiquer le motif de votre signalement", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Motif"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let motif = alertController.textFields![0].text!
            
            let map = [ "offerName" : selectedOffer.productName!,
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

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

// Pages Mes offres
struct MyOffersInfSideView: View {
    
    @State var offers : [Offer2] = [Offer2()]
    
    var body: some View {
        ZStack{
            VStack() {
                Text("Offres postulées").foregroundColor(Color.white).font(.custom("Raleway", size: 18)).padding()
                Spacer()
                if (offers.count > 0) {
                    ScrollView(showsIndicators: false){
                        ForEach(offers) { offer in
                            NavigationLink(destination:DetailMyOfferInfSideView(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
                                VStack{
                                    
                                    HStack{
                                        
                                        if (offer.productImg!.isEmpty) {
                                            Image("placeholder-image").resizable().frame(width: 150, height: 110).padding(.top)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:offer.productImg![0].imageData!)).renderingMode(.original).resizable().frame(width: 150, height: 110).padding(.top)                                  }
                                        Spacer()
                                        VStack {
                                            Text(String(offer.productName ?? "Pas de nom"))
                                                .foregroundColor(Color.white)
                                                .font(.custom("Raleway", size: 14))
                                            Spacer()
                                            Text(String(offer.productSubject ?? "Pas de thème"))
                                                .foregroundColor(Color.white)
                                                .font(.custom("Raleway", size: 14))
                                            Spacer()
                                        }
                                        Image("arrow")
                                            .padding()
                                        
                                    }
                                    Divider()
                                        .frame(width: 75.0, height: 1.0)
                                        .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                                        .padding()
                                }.foregroundColor(.white).padding([.leading,.trailing])
                                
                            }
                        }
                        Spacer()
                    }
                }
                else
                {
                    Text("Aucune offre actuellement").foregroundColor(Color.white)
                        .font(.custom("Raleway", size: 15)).italic()
                }
                
                Spacer()
                
            }.padding(.top,50)
        }
        
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            getMyOffers2() {
                response in
                self.offers = response
                if (!offers.isEmpty){
                    offers.removeFirst()
                }
            }
        }
    }
}

