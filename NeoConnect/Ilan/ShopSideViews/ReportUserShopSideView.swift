//
//  ReportUserShopSideView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 09/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire


struct ReportUserShopSideView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State var idUser : Int
    @State var pseudo : String
       @State private var subject : String = ""
       @State private var message : String = ""
    private var validated: Bool {
        !pseudo.isEmpty && !subject.isEmpty && !message.isEmpty}
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text("Signaler un utilisateur").foregroundColor(Color.white).font(.custom("Raleway", size: 20)).padding(.top, 50.0)
//                TextField("Pseudo*", text: $pseudo).frame(width: 150.0, height: 50.0).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                CustomTextField(placeholder: Text("Pseudo*").foregroundColor(.black),text: $pseudo
                                                                                      ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).frame(width: 150.0, height: 50.0)
                Divider()
                                   .frame(width: 200.0, height: 1.0)
                                   .background(Color(hex:"445173"))
//                TextField("Sujet*", text: $subject).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                CustomTextField(placeholder: Text("Sujet*").foregroundColor(.black),text: $subject
                                                                                                     ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                Divider()
                    .frame(width: 200.0, height: 1.0)
                                   .background(Color(hex:"445173"))
//                TextField("Message*", text: $message).foregroundColor(Color.white).frame(height: 200.0).multilineTextAlignment(.center).font(.custom("Raleway", size: 12))
                CustomTextField(placeholder: Text("Message*").foregroundColor(.black),text: $message
                                                                                                     ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).frame(height: 200.0).multilineTextAlignment(.center)
                Divider()
                    .frame(width: 300.0, height: 1.0)
                .background(Color(hex:"445173"))
                if (validated) {
                          Button(action:{
                            let _headers: HTTPHeaders = [
                                "Authorization": "Bearer " + accessToken  ]
                            let map = ["pseudo": self.pseudo,
                                                          "subject": self.subject, "message": self.message]
                            AF.request(url+"user/report/" + String(self.idUser),
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
                                         Alert(title: Text("Signaler l'utilisateur"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
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
            //.padding(.top, 20.0)
                .padding(.top,50)
            .frame(width: 300.0)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "16133C").opacity(0.95), Color(hex: "048136").opacity(0.1)]), startPoint: .top, endPoint: .bottom))
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

struct ReportUserShopSideView_Previews: PreviewProvider {
    static var previews: some View {
        ReportUserShopSideView(idUser: 1, pseudo: "Pseudo")
    }
}
