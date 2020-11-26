//
//  ShareOfferView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 31/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire

// Texte personnalisé
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

// Page Partage des publications
struct ShareOfferView: View {
    @Environment(\.presentationMode) var presentationMode
    var selectedOffer : Offer2
    @State private var showingAlert = false
    @State private var validator = true
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
                        Divider()
                        verifFb(facebook: facebook, validator: validator) .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Twitter").foregroundColor(.black),
                            text: $twitter
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifTwitter(twitter: twitter) .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Instagram").foregroundColor(.black),
                            text: $instagram
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifInsta(instagram: instagram) .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Pinterest").foregroundColor(.black),
                            text: $pinterest
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifPinterest(pinterest: pinterest).foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    Group {
                        
                        CustomTextField(
                            placeholder: Text("Twitch").foregroundColor(.black),
                            text: $twitch
                        ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        Divider()
                        verifTwitch(twitch: twitch).foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    }
                    CustomTextField(
                        placeholder: Text("Youtube").foregroundColor(.black),
                        text: $youtube
                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Divider()
                    verifYtb(youtube: youtube).foregroundColor(Color.red)
                        .font(.custom("Raleway", size: 15))
                    CustomTextField(
                        placeholder: Text("TikTok").foregroundColor(.black),
                        text: $tiktok
                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                }
                Divider()
                    verifTikTok(tiktok: tiktok)
                        .foregroundColor(Color.red)
                            .font(.custom("Raleway", size: 15))
                    .frame(width: 300.0, height: 1.0)
//                    .background(Color(hex:"445173"))
                if (!self.facebook.isEmpty || !self.twitter.isEmpty ||
                        !self.instagram.isEmpty ||
                        !self.pinterest.isEmpty ||
                        !self.twitch.isEmpty ||
                        !self.youtube.isEmpty ||
                        !self.tiktok.isEmpty)
                {
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
                else{
                    Text("Veuillez remplir au moins un champ")
                        .foregroundColor(Color.red)
                        .padding(.top)
                        .font(.custom("Raleway", size: 15))
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
    
    // Vérifications des liens
    
    func verifFb(facebook : String, validator: Bool) -> Text {
        if (facebook.hasPrefix("https://www.facebook.com/") || facebook.hasPrefix("facebook.com") || facebook.isEmpty)
        {
            return Text("")
        }
            self.validator = false
            return Text("Compte Facebook invalide")
    }
    func verifTwitter(twitter : String) -> Text {
        if (twitter.hasPrefix("https://www.twitter.com/") || twitter.hasPrefix("twitter.com") || twitter.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Twitter invalide")
    }
    
    func verifInsta(instagram : String) -> Text {
        if (instagram.hasPrefix("https://www.instagram.com/") || instagram.hasPrefix("instagram.com") || instagram.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Instagram invalide")
    }
    
    func verifPinterest(pinterest : String) -> Text {
        if (pinterest.hasPrefix("https://www.pinterest.fr/") || pinterest.hasPrefix("pinterest.fr") || pinterest.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Pinterest invalide")
    }
    
    func verifTwitch(twitch : String) -> Text {
        if (twitch.hasPrefix("https://www.twitch.tv/") || twitch.hasPrefix("twitch.tv") || twitch.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Twitch invalide")
    }
    
    func verifYtb(youtube : String) -> Text {
        if (youtube.hasPrefix("https://www.youtube.com/") || youtube.hasPrefix("youtube.com") || youtube.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Youtube invalide")
    }
    
    func verifTikTok(tiktok : String) -> Text {
        if (tiktok.hasPrefix("https://www.tiktok.com/") || tiktok.hasPrefix("tiktok.com") || tiktok.isEmpty)
        {
            return Text("")
        }
        return Text("Compte Tiktok invalide")
    }
    
    
}

struct ShareOfferView_Previews: PreviewProvider {
    static var previews: some View {
        var selectedOffer : Offer2 = Offer2()
        
        return Group {
            ShareOfferView(selectedOffer: selectedOffer,facebook : "facebook.com",twitter : "twitter.com", instagram: "",pinterest : "",twitch:  "twitch.tv",youtube: "",tiktok: "tiktok.com")
        }
    }
}




