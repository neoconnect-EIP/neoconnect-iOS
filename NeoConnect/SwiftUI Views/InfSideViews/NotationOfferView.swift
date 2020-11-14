//
//  NotationView.swift
//  Neoconnect iOS
//
//  Created by Ilan Cohen on 04/12/2019.
//  Copyright © 2019 Ilan Cohen. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire

// Page Notation d'une offre
struct NotationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var message = ""
    @Binding var rating: Int
    
    var selectedOffer : Offer2
    var label = ""
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    func myimage(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        ZStack {
            
            VStack() {
                Text("Noter").foregroundColor(Color.white).font(.custom("Raleway", size: 20))
                HStack {
                    if label.isEmpty == false {
                        Text(label)
                    }
                    
                    ForEach(1..<5 + 1) { number in
                        self.myimage(for: number)
                            .foregroundColor(number > self.rating ?
                                self.offColor : self.onColor)
                            .onTapGesture {
                                self.rating = number
                        }
                    }
                }.padding(.top, 50.0)
                TextField("Commentaire*", text: $message).foregroundColor(Color.white).frame(height: 200.0).multilineTextAlignment(.center).font(.custom("Raleway", size: 12))
                
                Divider()
                    .frame(width: 300.0, height: 1.0)
                    .background(Color(hex:"445173"))
                
                Button(action:{ rateAndComment(rating: self.rating, selectedOffer: self.selectedOffer, message: self.message)
                    self.showingAlert = true
                } ) {
                    Image("icons8-envoi-de-courriel-24")
                        .frame(width: 50.0, height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }.padding(30)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Noter l'offre"), message: Text("Votre note a bien été prise en compte."), dismissButton: .default(Text("Ok")))
                }
            }
            .padding(.top,50)
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
}
// Noter et commenter
func rateAndComment(rating: Int, selectedOffer: Offer2, message: String)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request(url+"offer/comment/" + String(selectedOffer.id), method: .post, parameters: ["comment" : message], encoding: URLEncoding.default, headers: _headers) .responseString { response in
        debugPrint(response)
    }
    AF.request(url+"offer/mark/" + String(selectedOffer.id), method: .post, parameters: ["mark" : rating], encoding: URLEncoding.default, headers: _headers) .responseString { response in
        debugPrint(response)
    }
}


struct NotationView_Previews: PreviewProvider {
    static var previews: some View {
        NotationView(rating: .constant(4), selectedOffer: Offer2())
    }
}
