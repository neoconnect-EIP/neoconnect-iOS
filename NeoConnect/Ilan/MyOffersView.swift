//
//  MyOffersView.swift
//  Neoconnect iOS
//
//  Created by Ilan Cohen on 30/11/2019.
//  Copyright © 2019 Ilan Cohen. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire
import KingfisherSwiftUI


struct myOffer: Codable,Identifiable {
var id : Int
var idUser: Int
var idOffer: Int
var createdAt: String?
var updatedAt: String?
    init() {
        id = 0
        idUser = 0
        idOffer = 0
        createdAt = ""
        updatedAt = ""
    }
}

var ID = UserDefaults.standard.string(forKey: "id")!

func getMyOffers(completion: @escaping ([myOffer]) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    var myOffers: [myOffer] = [myOffer()]
    AF.request("http://168.63.65.106/offer/apply/user/" + String(ID), method: .get, encoding: URLEncoding.default, headers: _headers).responseString { response in
        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
                 myOffers = try decoder.decode([myOffer].self, from: jsonData)
            completion(myOffers)
             }
             catch
             {
                 debugPrint(error)
             }
    }
}

func getMyOffers3(offerID: Int, completion: @escaping (Offer2) -> Void)
{
    var offer : [Offer2] = [Offer2()]
    let _headers: HTTPHeaders = [
                       "Authorization": "Bearer " + accessToken            ]
             AF.request("http://168.63.65.106/offer/" + String(offerID), method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        
                       var jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
                    jsonString.insert("[", at: jsonString.startIndex)
                    jsonString.insert("]", at: jsonString.endIndex)
                
                       let jsonData = Data(jsonString.utf8)
                       let decoder = JSONDecoder()
                       do {
                            offer = try decoder.decode([Offer2].self, from: jsonData)
                                completion(offer[0])
                       }
                            catch
                            {
                                debugPrint(error)
                            }
                   }
}

func getMyOffers2(completion: @escaping ([Offer2]) -> Void)
{
    getMyOffers() {
        response in
        var offers: [Offer2] = [Offer2()]
        var i = 0
        while (i != response.count)
        {
            getMyOffers3(offerID: response[i].idOffer) {
                response in
                offers = offers + [response]
                completion(offers)
            }
            i += 1
        }
        }
}

struct DetailMyOffer2: View {
    @State private var rating = 0
    var selectedOffer : Offer2
    var date : String

var body: some View {
    VStack(alignment: .center, spacing: 20.0) {
         KFImage(URL(string:selectedOffer.productImg![0].imageData!)).resizable().frame(width: 100, height: 100)
              .clipShape(Circle()).clipped().padding(10).shadow(radius: 3)
          Text(String(selectedOffer.productName!)).multilineTextAlignment(.center).font(.headline)
        HStack{
          Text(String(selectedOffer.productSubject ?? "Pas de thème renseigné")).font(.subheadline).fontWeight(.light).multilineTextAlignment(.leading)
          .padding(.trailing,30)
      Text(String(selectedOffer.productSex!)).font(.subheadline).fontWeight(.light).multilineTextAlignment(.leading)
        .padding(.trailing,30)
        }
      Divider()
                     .padding(.trailing,50)
                     .padding(.leading,50)
        Text(String(selectedOffer.productDesc!)).font(.body).fontWeight(.light).multilineTextAlignment(.center)
      Text("Crée le " + date).foregroundColor(Color.gray)
          .font(Font.system(size: 14)).italic()
        Text("Vous avez postulé à cette offre.").multilineTextAlignment(.center)
        NavigationLink(destination: NotationView(selectedOffer: selectedOffer, rating: $rating)) {
           Text("Noter")
           }
    }.padding(20)
}
}

struct MyOffersView: View {
     @State var offers : [Offer2] = [Offer2()]
      
      var body: some View {
          NavigationView {
              List(offers) { offer in
                NavigationLink(destination:DetailMyOffer2(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
                  HStack {
                      KFImage(URL(string:offer.productImg![0].imageData!)).resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
                      Text(String(offer.productName!))
                  }
                  }
              }
              .navigationBarTitle(Text("Mes offres"))
            }
          .onAppear {
                     getMyOffers2() {
                         response in
                            self.offers = response
                            self.offers.remove(at:0)
                         }
                     }
      }
}

struct MyOffersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOffersView()
    }
}
