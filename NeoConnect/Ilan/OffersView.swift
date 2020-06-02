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
import Combine
import KingfisherSwiftUI

struct offerImage: Codable {
    let imageName: String?
    let imageData: String?
}

struct Offer2: Codable,Identifiable{
var id : Int
var idUser: Int
var productImg: [offerImage]?
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
        productImg = [offerImage(imageName: "", imageData: "")]
        productSex = ""
        productDesc = ""
        productSubject = ""
        createdAt = ""
        updatedAt = ""
    }
}

let accessToken = UserDefaults.standard.string(forKey: "Token")!

func getOffers(completion: @escaping ([Offer2]) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    var offers: [Offer2] = [Offer2()]
    AF.request("http://168.63.65.106/offer/list", method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            offers = try decoder.decode([Offer2].self, from: jsonData)
            completion(offers)
        }
        catch
        {
            debugPrint(error)
        }
    }
}

func postulate(offer : Offer2) {
    let _headers: HTTPHeaders = [
          "Authorization": "Bearer " + accessToken            ]
    AF.request("http://168.63.65.106/offer/apply/" + String(offer.id), method: .put, encoding: URLEncoding.default, headers: _headers) .responseString { response in
         print(response)
      }
}

struct DetailOffer: View {
    @State private var showingAlert = false
    var selectedOffer : Offer2
    var date : String
var body: some View {
    VStack(alignment: .center, spacing: 20.0) {
       KFImage(URL(string:selectedOffer.productImg![0].imageData!)).resizable().frame(width: 100, height: 100)
            .clipShape(Circle()).clipped().shadow(radius: 3)
        Text(String(selectedOffer.productName!)).multilineTextAlignment(.center).font(.headline)
        HStack {
        Text(String(selectedOffer.productSubject ?? "Pas de thème renseigné")).font(.subheadline).fontWeight(.light).multilineTextAlignment(.leading)
        .padding(.trailing,30)
    Text(String(selectedOffer.productSex!)).font(.subheadline).fontWeight(.light).multilineTextAlignment(.leading)
        .padding(.trailing,30)
        }
    Divider()
        .padding(.trailing,50)
                   .padding(.leading,50)
        Text(String(selectedOffer.productDesc!)).font(.body).fontWeight(.light).multilineTextAlignment(.center)
        Button(action: {postulate(offer: self.selectedOffer)
            self.showingAlert = true
        }) {
            Text("Postuler")
        }
        .alert(isPresented: $showingAlert) {
                       Alert(title: Text("Postuler à une offre"), message: Text("Vous avez postulé à cette offre."), dismissButton: .default(Text("Ok")))
                   }
        Text("Crée le " + date).foregroundColor(Color.gray)
        .font(Font.system(size: 14)).italic()
    }
}
}
struct OffersView: View {
    @State var offers : [Offer2] = [Offer2()]
    @State var searchText : String = ""
    var body: some View {
        NavigationView {
            VStack {
            SearchBar(text: self.$searchText)
                List(offers.filter({ searchText.isEmpty ? true : $0.productName!.localizedCaseInsensitiveContains(searchText) })) { offer in
               
        NavigationLink(destination:DetailOffer(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
                HStack {
                    KFImage(URL(string:offer.productImg![0].imageData!)).resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
                    Text(String(offer.productName!))
                }
                }
            }
            .navigationBarTitle(Text("Offres du moment"))
        }
        .onAppear {
                   getOffers() {
                       response in
                        self.offers = response
                   // print(self.offers[0].productImg![0].imageData!)
                       }
                   }
        }
    }

}

struct OffersView_Previews: PreviewProvider {

    static var previews: some View {
        OffersView()
    }
}

struct SearchBar: View {
    @Binding var text: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Rechercher...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8).overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Annuler")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

/*struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}*/
