//
//  NotationUserView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 01/06/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire

struct NotationUserView: View {

var userId : Int
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
            Button(action:{ rateAndCommentUser(rating: self.rating, userId: self.userId, message: self.message)} ) {
        Text("Envoyer")
        }.padding(30)
        }
    }
}

func rateAndCommentUser(rating: Int, userId: Int, message: String)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request("http://168.63.65.106/user/comment/" + String(userId), method: .post, parameters: ["comment" : message], encoding: URLEncoding.default, headers: _headers) .responseString { response in
        debugPrint(response)
    }
    AF.request("http://168.63.65.106/user/mark/" + String(userId), method: .post, parameters: ["mark" : rating], encoding: URLEncoding.default, headers: _headers) .responseString { response in
        debugPrint(response)
    }
}


struct NotationUserView_Previews: PreviewProvider {
    static var previews: some View {
        NotationView(selectedOffer: Offer2(), rating: .constant(4))
    }
}

