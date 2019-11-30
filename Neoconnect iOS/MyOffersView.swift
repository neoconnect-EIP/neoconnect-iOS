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

var userID = 5

func getMyOffers(completion: @escaping ([Offer]) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    var offers: [Offer] = [Offer()]
    AF.request("http://168.63.65.106/offer/apply/user/" + String(userID), method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            offers = try decoder.decode([Offer].self, from: jsonData)
            completion(offers)
        }
        catch
        {
            debugPrint(error)
        }
    }
}

struct DetailMyOffer: View {
    var selectedOffer : Offer
var body: some View {
    HStack {
    Text(String(selectedOffer.productName!))
    Text(String(selectedOffer.productSex!))
    Text(String(selectedOffer.productDesc!))
    Text(String(selectedOffer.createdAt!))
    Text("Vous avez postulé à cette offre")
    
    }
}
}
struct MyOffersView: View {
     @State var offers : [Offer] = [Offer()]
      
      var body: some View {
          NavigationView {
              List(offers) { offer in
                  
                  NavigationLink(destination:DetailMyOffer(selectedOffer: offer)) {
                  HStack {
                      Image("jean").resizable().frame(width: 50, height: 50)
                          .clipShape(Circle()).clipped()
                      Text(String(offer.productName!))
                  }.navigationBarTitle(Text(String(offer.productName!)))
                  }
      
              }
              .navigationBarTitle(Text("Mes offres"))
          }
          .onAppear {
                     getMyOffers() {
                         response in
                          self.offers = response
                         }
                     }
      }
}

struct MyOffersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOffersView()
    }
}
