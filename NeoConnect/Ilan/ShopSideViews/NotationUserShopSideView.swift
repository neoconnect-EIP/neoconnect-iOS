//
//  NotationUserShopSideView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 09/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire


struct NotationUserShopSideView: View {
@State private var showingAlert = false
var userId : Int
@State var rating: Int

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
            Button(action:{ rateAndCommentUser(rating: self.rating, userId: self.userId, message: self.message)
                self.showingAlert = true} ) {
         Image("icons8-envoi-de-courriel-24")
                                              .frame(width: 50.0, height: 50.0)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
        }.padding(30)
            .alert(isPresented: $showingAlert) {
                           Alert(title: Text("Noter l'utilisateur"), message: Text("Votre note a bien été prise en compte."), dismissButton: .default(Text("Ok")))
                       }
        }
        }  .frame(maxWidth:.infinity,maxHeight: .infinity)
                                            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "16133C").opacity(0.95), Color(hex: "048136").opacity(0.1)]), startPoint: .top, endPoint: .bottom))
    }
}

struct NotationUserShopSideView_Previews: PreviewProvider {
    static var previews: some View {
        NotationUserShopSideView(userId: 1, rating: 1)
    }
}
