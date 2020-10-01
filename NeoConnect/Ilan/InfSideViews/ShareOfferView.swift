//
//  ShareOfferView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 31/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct ShareOfferView: View {
    @Environment(\.presentationMode) var presentationMode
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
                VStack{
                    Group {
                        CustomTextField(
                            placeholder: Text("Facebook").foregroundColor(.black),
                            text: $facebook
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        //                        TextField("Facebook", text: $facebook).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Twitter").foregroundColor(.black),
                            text: $twitter
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Instagram").foregroundColor(.black),
                            text: $instagram
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Pinterest").foregroundColor(.black),
                            text: $pinterest
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Twitch").foregroundColor(.black),
                            text: $twitch
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                    }
                    CustomTextField(
                        placeholder: Text("Youtube").foregroundColor(.black),
                        text: $youtube
                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Divider()
                    
                    CustomTextField(
                        placeholder: Text("TikTok").foregroundColor(.black),
                        text: $tiktok
                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                }
                
                Divider()
                    .frame(width: 300.0, height: 1.0)
                    .background(Color(hex:"445173"))
                Button(action:{
                    let _headers: HTTPHeaders = [
                        "Authorization": "Bearer " + accessToken  ]
                    let map = ["facebook": self.facebook,
                               "twitter": self.twitter,
                               "instagram": self.instagram,
                               "pinterest": self.pinterest,
                               "twitch": self.twitch,
                               "youtube": self.youtube,
                               "tiktok": self.tiktok]
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
                
            .padding(20.0)
            
            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
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

struct ShareOfferView_Previews: PreviewProvider {
    static var previews: some View {
        var selectedOffer : Offer2 = Offer2()
        
        return ShareOfferView(selectedOffer: selectedOffer,facebook : "Test",twitter : "Test", instagram: "Test",pinterest : "Test",twitch:  "Test",youtube: "Test",tiktok: "Test")
    }
}



