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

struct NotationView: View {

@State private var showingAlert = false
var selectedOffer : Offer2
@Binding var rating: Int

@State private var message = ""
    
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
        VStack() {
            TextField("Commentaires", text: $message).frame(width: 300, height: 300).textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 100, height: 200)
                   .multilineTextAlignment(.center)
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
            }.padding()
            Button(action:{ rateAndComment(rating: self.rating, selectedOffer: self.selectedOffer, message: self.message)
                self.showingAlert = true
            } ) {
        Text("Envoyer")
        }.padding(30)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Noter l'offre"), message: Text("Votre note a bien été prise en compte."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

func rateAndComment(rating: Int, selectedOffer: Offer2, message: String)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request("http://168.63.65.106/offer/comment/" + String(selectedOffer.id), method: .post, parameters: ["comment" : message], encoding: URLEncoding.default, headers: _headers) .responseString { response in
        debugPrint(response)
    }
    AF.request("http://168.63.65.106/offer/mark/" + String(selectedOffer.id), method: .post, parameters: ["mark" : rating], encoding: URLEncoding.default, headers: _headers) .responseString { response in
        debugPrint(response)
    }
}


struct NotationView_Previews: PreviewProvider {
    static var previews: some View {
        NotationView(selectedOffer: Offer2(), rating: .constant(4))
    }
}
