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

func removeApply(offer : Offer2) {
    let _headers: HTTPHeaders = [
          "Authorization": "Bearer " + accessToken            ]
    AF.request(url+"offer/noapply/" + String(offer.id), method: .delete, encoding: URLEncoding.default, headers: _headers) .responseString { response in
         print(response)
      }
}

struct DetailMyOfferInfSideView: View {
    @State private var showingAlert = false
    @State private var rating = 0
    var selectedOffer : Offer2
    var date : String

var body: some View {
    ZStack{
      
    VStack(alignment: .center, spacing: 20.0) {

//        Button(action: {print("Partager une offre & Signaler")}) {
//            Image("Plus")
//                .padding(.leading, 300.0)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
//            }
         Text(String(selectedOffer.productName!)).foregroundColor(Color.white).font(.custom("Raleway", size: 20))
          if (selectedOffer.productImg!.isEmpty) {
                           Image("noImage").resizable().frame(width: 100, height: 100)
                           .clipShape(Circle()).clipped().shadow(radius: 3)

                                           }
                                           else {
            KFImage(URL(string:selectedOffer.productImg![0].imageData!)).resizable().frame(width: 100, height: 100)
                      .clipShape(Circle()).clipped().shadow(radius: 3)
                                    }
        
      Text(String(selectedOffer.brand ?? "Marque")).foregroundColor(Color.white).font(.custom("Raleway", size: 16))
         Divider()
                   .frame(width: 75.0, height: 1.0)
                   .background(Color(hex: "445173"))
        Group{
            HStack {
                Text("Sexe:").foregroundColor(Color.white).font(.custom("Raleway", size: 16))
if selectedOffer.productSex == "Male" || selectedOffer.productSex == "Homme"
{
    Image("circlefill")
                }
                else
{
    Image("circle")

                }
        Text("Homme").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
                if selectedOffer.productSex == "Female" || selectedOffer.productSex == "Femme"
                {
                    Image("circlefill")
                                }
                                else
                {
                    Image("circle")

                                }
                        Text("Femme").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
            }
                   
        Text(String(selectedOffer.productDesc!)).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.vertical)
        
        Divider()
            .frame(width: 245.0, height: 1.0)
           .background(Color(hex: "445173"))
            Text(String(selectedOffer.productSubject ?? "Pas de thème renseigné")).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
        Divider()
                   .frame(width: 75, height: 1.0)
                   .background(Color(hex: "445173"))
        }
        HStack{
        NavigationLink(destination: NotationView(selectedOffer: selectedOffer, rating: $rating)) {
            ZStack
                {
                    Image("login")
                        .foregroundColor(Color(hex: "445173"))
                    Text("Noter").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
            }
           }
        NavigationLink(destination: ShareOfferView(selectedOffer: selectedOffer, facebook: "", twitter: "", instagram: "", pinterest: "", twitch: "", youtube: "", tiktok: "")) {
                         ZStack
                                        {
                                    Image("login").foregroundColor(Color(hex: "445173"))

                                   Text("Valider").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                                    }                      }
         Button(action: {removeApply(offer: self.selectedOffer)
                  self.showingAlert = true
              }) {
                ZStack
                               {
                                Image("login").foregroundColor(Color(hex: "445173"))

                                    .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                Text("Annuler ma candidature").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                           }
                  
              }
              .alert(isPresented: $showingAlert) {
                             Alert(title: Text("Annuler ma candidature"), message: Text("Vous avez annulé votre candidature."), dismissButton: .default(Text("Ok")))
                         }
        }
   
//        Text("Crée le " + date).foregroundColor(Color.gray)
//        .font(Font.system(size: 14)).italic()
    }
    } .frame(maxWidth:.infinity,maxHeight: .infinity)
           .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
}
}

struct MyOffersInfSideView: View {
  
     @State var offers : [Offer2] = [Offer2()]
      
      var body: some View {
        ZStack{
            VStack() {
                           Text("Offres postulées").foregroundColor(Color.white).font(.custom("Raleway", size: 18))
                Spacer()
                ScrollView(showsIndicators: false){
              ForEach(offers) { offer in
                NavigationLink(destination:DetailMyOfferInfSideView(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
                    VStack{
                                                    
                        HStack{
                          

   if (offer.productImg!.isEmpty) {
    Image("noImage").resizable().frame(width: 150, height: 110).padding(.top)

                                                      }
                                                      else {
    KFImage(URL(string:offer.productImg![0].imageData!)).renderingMode(.original).resizable().frame(width: 150, height: 110).padding(.top)                                  }
                            Spacer()
                            VStack {
                                                                                              Text(String(offer.productName!))
                                                                                                                      .foregroundColor(Color.white)
                                                                                                                .font(.custom("Raleway", size: 14))
                                                                                              Spacer()
                                                                                                                     Text(String(offer.productSubject!))
                                                                                                                      .foregroundColor(Color.white)
                                                                                                                                           .font(.custom("Raleway", size: 14))
                                                                                                                         Spacer()
                            ZStack() {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 97.0, height: 20.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/25/*@END_MENU_TOKEN@*/)
                                if offer.average != nil
                                {
                                    HStack{
                                    Text(String(offer.average!.rounded()))
                                                            .padding().foregroundColor(Color.black)
                                                            .font(.custom("Raleway", size: 14))
                                        Image(systemName: "star.fill").foregroundColor(.yellow)
                                    }
                                }
                                else {
                                    HStack{
                                    Text("0")                    .padding().foregroundColor(Color.black)
                                                                            .font(.custom("Raleway", size: 14))
                                        Image(systemName: "star.fill").foregroundColor(.yellow)
                                    }
                                }
                            
                            }
                        }
                            Image("arrow")
                                .padding()

                        }
                        Divider()
                            .frame(width: 75.0, height: 1.0)
                            .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                    }.foregroundColor(.white).padding([.leading,.trailing])
                
                }
                }
                    Spacer()
                }
                Spacer()
                
}
}
            
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .onAppear {
                            getMyOffers2() {
                                response in
                                   self.offers = response
                                   self.offers.remove(at:0)
                                }
                            }
}
}
