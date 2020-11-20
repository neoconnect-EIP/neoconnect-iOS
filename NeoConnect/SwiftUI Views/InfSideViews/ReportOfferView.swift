//
//  ReportOfferView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 17/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire

// Signaler une offre
struct ReportOfferView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State var offerName : String
    @State var idOffer : String
    @State private var message : String = ""
    private var validated: Bool {
        !message.isEmpty}
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text("Signaler une offre").foregroundColor(Color.white).font(.custom("Raleway", size: 20)).padding(.top, 100.0)
                CustomTextField(placeholder: Text("Nom de l'offre*").foregroundColor(.black),
                                text: $offerName
                ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).frame(width: 150.0, height: 50.0)
                Divider()
                    .frame(width: 200.0, height: 1.0)
                    .background(Color(hex:"445173"))
                TextField("Message*", text: $message).foregroundColor(Color.white).frame(height: 200.0).multilineTextAlignment(.center).font(.custom("Raleway", size: 12))
                
                Divider()
                    .frame(width: 300.0, height: 1.0)
                    .background(Color(hex:"445173"))
                if (validated) {
                    Button(action:{
                        let _headers: HTTPHeaders = [
                            "Authorization": "Bearer " + accessToken  ]
                        let map = [ "offerName" : self.offerName,
                                    "message": self.message]
                        AF.request(url+"offer/report/" + String(self.idOffer),
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
                        Alert(title: Text("Signaler l'offre"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
                    }
                }
                else {
                    Text("Veuillez remplir tous les champs")
                        .foregroundColor(Color.red)
                        .padding(.top)
                        .font(.custom("Raleway", size: 15))
                    
                }
                Spacer()
            }
                .padding(.top, 50.0)
                .frame(width: 300.0)
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

struct ReportOfferView_Previews: PreviewProvider {
    static var previews: some View {
        ReportOfferView(offerName: "Test", idOffer: "1")
    }
}

