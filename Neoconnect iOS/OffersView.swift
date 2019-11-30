//
//  OffersView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire

struct Offer: Codable,Identifiable {
var id : Int
var idUser: Int
var productImg: String?
var productName: String?
var productSex: String?
var productDesc: String?
var productSubject: String?
var createdAt: String?
var updatedAt: String?
    init() {
        id = 0
        idUser = 0
        productName = ""
        productImg = ""
        productSex = ""
        productDesc = ""
        productSubject = ""
        createdAt = ""
        updatedAt = ""
    }
}

let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjYsImlhdCI6MTU3NDYyMzUzNSwiZXhwIjoxNTc0NjI3MTM1fQ.-esbRtBL3NCcvKQJpCqn82DpppnNwKPh9_cwO4T6suc"

func getOffers(completion: @escaping ([Offer]) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    var offers: [Offer] = [Offer()]
    AF.request("http://168.63.65.106/offer/list", method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
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

func postulate(offer : Offer) {
    let _headers: HTTPHeaders = [
          "Authorization": "Bearer " + accessToken            ]
    AF.request("http://168.63.65.106/offer/apply/" + String(offer.id), method: .put, encoding: URLEncoding.default, headers: _headers) .responseString { response in
         print(response)
      }
}

struct DetailOffer: View {
    var selectedOffer : Offer
var body: some View {
    HStack {
    Text(String(selectedOffer.productName!))
    Text(String(selectedOffer.productSex!))
    Text(String(selectedOffer.productDesc!))
    Text(String(selectedOffer.createdAt!))
        Button(action: {postulate(offer: self.selectedOffer)}) {
        Text("Postuler")
    }
    }
}
}

struct OffersView: View {
    @State var offers : [Offer] = [Offer()]
    
    var body: some View {
        NavigationView {
            List(offers) { offer in
                
                NavigationLink(destination:DetailOffer(selectedOffer: offer)) {
                HStack {
                    Image("jean").resizable().frame(width: 50, height: 50)
                        .clipShape(Circle()).clipped()
                    Text(String(offer.productName!))
                }.navigationBarTitle(Text(String(offer.productName!)))
                }
    
            }
            .navigationBarTitle(Text("Offres du moment"))
        }
        .onAppear {
                   getOffers() {
                       response in
                        self.offers = response
                       }
                   }
    }

}

struct OffersView_Previews: PreviewProvider {
    static var previews: some View {
        OffersView()
    }
}

