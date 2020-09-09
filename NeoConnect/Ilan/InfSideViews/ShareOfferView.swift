//
//  ShareOfferView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 31/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire

struct ShareOfferView: View {
    var selectedOffer : Offer2
    @State private var showingAlert = false
    @State var facebook : String
    @State var twitter : String
    @State var instagram : String
    @State var pinterest : String
    @State var twitch : String
    @State var youtube : String
    @State var tiktok : String

    
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text("Partage des publications").foregroundColor(Color.white).font(.custom("Raleway", size: 20))
                TextField("Facebook", text: $facebook).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
     
                TextField("Twitter*", text: $twitter).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
               
            TextField("Instagram", text: $instagram).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        
                TextField("Pinterest", text: $pinterest).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            
                TextField("Twitch", text: $twitch).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            
                TextField("Youtube", text: $youtube).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                             
                TextField("TikTok", text: $tiktok).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                              
                
                Divider()
                    .frame(width: 300.0, height: 1.0)
                .background(Color(hex:"445173"))
                          Button(action:{
                            let _headers: HTTPHeaders = [
                                "Authorization": "Bearer " + accessToken  ]
                            let map = ["facebook": self.facebook,
                                                          "twitter": self.twitter, "instagram": self.instagram]
                            AF.request(url+"offer/sharePublication/" + String(self.selectedOffer.id),
                                                          method: .post,
                                                          parameters: map,
                                                          encoding: URLEncoding.default,headers: _headers).response { response in
                                                   debugPrint(response)
                            }
                            self.showingAlert = true

                          }) {
                            Image("icons8-envoi-de-courriel-24")
                                .frame(width: 50.0, height: 50.0)
                                  .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                              
                          }
                          .frame(width: 300.0)
                          .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .alert(isPresented: $showingAlert) {
                                         Alert(title: Text("Partager les publications"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
                        
                                     }
                     
            }
            .padding(.top, 20.0)
            .frame(width: 300.0)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))

    }
}

//struct ShareOfferView_Previews: PreviewProvider {
//    static var previews: some View {
//        var selectedOffer : Offer2
//
//        ShareOfferView(selectedOffer: selectedOffer,facebook : "Test",twitter : "Test", instagram: "Test",pinterest : "Test",twitch:  "Test",youtube: "Test",tiktok: "Test")
//    }
//}



