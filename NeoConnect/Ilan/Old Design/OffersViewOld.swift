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

//
//func getOffers(completion: @escaping ([Offer2]) -> Void)
//{
//    let _headers: HTTPHeaders = [
//        "Authorization": "Bearer " + accessToken            ]
//    var offers: [Offer2] = [Offer2()]
//    AF.request(url+"offer/list", method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
//        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
//        let jsonData = Data(jsonString.utf8)
//        let decoder = JSONDecoder()
//        do {
//            offers = try decoder.decode([Offer2].self, from: jsonData)
//            completion(offers)
//        }
//        catch
//        {
//            debugPrint(error)
//        }
//    }
//}


//struct OffersView: View {
//    @State var offers : [Offer2] = [Offer2()]
//    @State var searchText : String = ""
//    var body: some View {
//        NavigationView {
//            VStack {
//            SearchBar(text: self.$searchText)
//                List(offers.filter({ searchText.isEmpty ? true : $0.productName!.localizedCaseInsensitiveContains(searchText) })) { offer in
//
//        NavigationLink(destination:DetailOffer(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
//                HStack {
//                    if (offer.productImg!.isEmpty) {
//                    Image("noImage").resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
//
//                                    }
//                                    else {
// KFImage(URL(string:offer.productImg![0].imageData!)).resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()                                    }
//                    Text(String(offer.productName!))
//                }
//                }
//            }
//            .navigationBarTitle(Text("Offres du moment"))
//        }
//
//        .onAppear {
//                   getOffers() {
//                       response in
//                        self.offers = response
//                    print(self.offers)
//                   // print(self.offers[0].productImg![0].imageData!)
//                       }
//                   }
//        }
//    }
//
//}

//struct OffersView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        DetailOffer(selectedOffer: offer)
//    }
//}

//struct SearchBar: View {
//    @Binding var text: String
//
//    @State private var isEditing = false
//
//    var body: some View {
//        HStack {
//
//            TextField("Rechercher...", text: $text)
//                .padding(7)
//                .padding(.horizontal, 25)
//                .background(Color(.systemGray6))
//                .cornerRadius(8).overlay(
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 8)
//
//                        if isEditing {
//                            Button(action: {
//                                self.text = ""
//                            }) {
//                                Image(systemName: "multiply.circle.fill")
//                                    .foregroundColor(.gray)
//                                    .padding(.trailing, 8)
//                            }
//                        }
//                    }
//                )
//                .padding(.horizontal, 10)
//                .onTapGesture {
//                    self.isEditing = true
//                }
//
//            if isEditing {
//                Button(action: {
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                    self.isEditing = false
//                    self.text = ""
//
//                }) {
//                    Text("Annuler")
//                }
//                .padding(.trailing, 10)
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
//        }
//    }
//}

/*struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}*/

//struct OffersTestView: View {
//
//     @State var offers : [Offer2] = [Offer2()]
//
//      var body: some View {
//        ZStack{
//            VStack(alignment: .leading) {
//                           Text("Bonjour, Gaiden").foregroundColor(Color.white).font(.custom("Raleway", size: 28))
//                Divider()
//                    .frame(width: 82.0, height: 3.0)
//                                           .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
//                Spacer()
//                Text("Offres du moment").foregroundColor(Color.white).font(.custom("Raleway", size: 17))
//                ScrollView{
//              ForEach(offers) { offer in
//                NavigationLink(destination:DetailMyOfferTestView(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
//                    HStack{
//
//                        HStack{
//
//
//   if (offer.productImg!.isEmpty) {
//    Image("noImage").resizable().frame(width: 150, height: 110).padding(.top)
//
//                                                      }
//                                                      else {
//    KFImage(URL(string:offer.productImg![0].imageData!)).renderingMode(.original).resizable().frame(width: 150, height: 110).padding(.top)                                  }
//                            Spacer()
//                            VStack {
//                                                                                              Text(String(offer.productName!))
//                                                                                                                      .foregroundColor(Color.white)
//                                                                                                                .font(.custom("Raleway", size: 14))
//                                                                                              Spacer()
//                                                                                                                     Text(String(offer.productSubject!))
//                                                                                                                      .foregroundColor(Color.white)
//                                                                                                                                           .font(.custom("Raleway", size: 14))
//                                                                                                                         Spacer()
//                            ZStack() {
//                            RoundedRectangle(cornerRadius: 5)
//                                .frame(width: 97.0, height: 20.0)
//                            .shadow(radius: /*@START_MENU_TOKEN@*/25/*@END_MENU_TOKEN@*/)
//                                if offer.average != nil
//                                {
//                                    Text(String(offer.average!))
//                                                            .padding().foregroundColor(Color.black)
//                                                            .font(.custom("Raleway", size: 14))
//                                }
//                                else {
//                                    Text("0")                    .padding().foregroundColor(Color.black)
//                                                                            .font(.custom("Raleway", size: 14))
//                                }
//
//                            }
//                        }
//                            Image("arrow")
//                                .padding()
//
//                        }
//                        Divider()
//                            .frame(width: 75.0, height: 1.0)
//                            .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
//                    }.foregroundColor(.white).padding([.leading,.trailing])
//
//                }
//                }
//                    Spacer()
//                }
//                Spacer()
//
//            }
//            .padding([.top, .leading], 70.0)
//}
//
//        .frame(maxWidth:.infinity,maxHeight: .infinity)
//        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
//        .onAppear {
////                              getOffers() {
//                     response in
//                      self.offers = response
//                  print(self.offers)
//                            }
//}
//}

//struct MyOffersTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        let offerss : [Offer2] = [Offer2()]
//        return DetailMyOfferTestView(selectedOffer: offerss[0], date: "21")
//    }
//}

//struct MyOffersTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        let offerss : [Offer2] = [Offer2()]
//        return MyOffersTestView(offers: offerss)
//    }
//}

//struct OffersTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        let offerss : [Offer2] = [Offer2()]
//        return OffersTestView(offers: offerss)
//    }
//}

//struct Test2: View {
//    @State var offers : [Offer2] = [Offer2()]
//       @State var searchText : String = ""
//       var body: some View {
//           NavigationView {
//               VStack {
//               SearchBar(text: self.$searchText)
//                   List(offers.filter({ searchText.isEmpty ? true : $0.productName!.localizedCaseInsensitiveContains(searchText) })) { offer in
//
//           NavigationLink(destination:DetailOffer(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
//                   HStack {
//                     //  KFImage(URL(string:offer.productImg![0].imageData!)).resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
//                       Text(String(offer.productName!))
//                   }
//                   }
//               }
//               .navigationBarTitle(Text("Offres du moment"))
//           }
//
//           .onAppear {
//                      getOffers() {
//                          response in
//                           self.offers = response
//                      // print(self.offers[0].productImg![0].imageData!)
//                          }
//                      }
//           }
//       }
//
//}
//
//struct Test3: View {
//    @State var offers : [Offer2] = [Offer2()]
//    @State var searchText : String = ""
//    var body: some View {
//        ZStack() {
//
//              VStack(alignment: .leading) {
//                Text("Offres du moment").foregroundColor(Color.white).font(.custom("Raleway", size: 20)).padding(.vertical, 50.0)
//
//                  SearchBar(text: self.$searchText)
//                                 List(offers.filter({ searchText.isEmpty ? true : $0.productName!.localizedCaseInsensitiveContains(searchText) })) { offer in
//
//                         NavigationLink(destination:DetailOffer(selectedOffer: offer,date: String(offer.createdAt!).components(separatedBy: "T")[0])) {
//                            HStack() {
//                                                            ZStack {
//                                                                RoundedRectangle(cornerRadius: 25)
//                                                                    .frame(width: 180.0, height: 230.0)
//                                                                .shadow(radius: /*@START_MENU_TOKEN@*/25/*@END_MENU_TOKEN@*/)
//                                                                VStack{
//                                                                  //  KFImage(URL(string:offer.productImg![0].imageData!)).resizable().frame(width: 150, height: 110)
//                                                                    Image("offerImage")
//                                                                        .padding(.top)
//                                                                    Spacer()
//                                                                                           Text(String(offer.productName!))
//                                                                                            .foregroundColor(Color.black)
//                                                                                      .font(.custom("Raleway", size: 15))
//                                                                    Spacer()
//                                                                                           Text(String(offer.productSubject!))
//                                                                                            .foregroundColor(Color.black)
//                                                                                                                 .font(.custom("Raleway", size: 15))
//                                                                                               Spacer()
//                                                                    ZStack{
//                                                                    RoundedRectangle(cornerRadius: 10)
//                                                                        .padding(.bottom)
//                                                                        .frame(width: 100.0, height: 40.0)
//                                                                        .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
//                                                                        .opacity(0.3)
//                                                                        HStack{
//                                                                        Text("4,6")
//                                                                            .padding([.leading, .bottom]).foregroundColor(Color.black)
//                                                                            .font(.custom("Raleway", size: 15))
//                                                                            Image("ratingStar")
//                                                                                .padding([.bottom, .trailing])
//                                                                                .frame(width: 20.0, height: 20.0)
//
//                                                                        }
//                                                                    }
//                                                                }
//
//                                                            }
//                                                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
//
//                                                            Divider()
//
//                                                        }
//                                                        .padding(.top)
//                            .frame(width: 300.0, height: 400.0)
//                                                        Spacer()
//                                 }
//                             }
//
//                  .padding(.top)
//                                 .frame(width: 350.0, height: 600.0)
//
//                  Spacer()
//
//          }
//              .padding(.top, 20.0)
//                        .frame(width: 300.0)
////            .onAppear {
////                                getOffers() {
////                                    response in
////                                     self.offers = response
////                                // print(self.offers[0].productImg![0].imageData!)
////                                    }
////                                }
//      }
//          .frame(maxWidth:.infinity,maxHeight: .infinity)
//              .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
//
//      }
//}
