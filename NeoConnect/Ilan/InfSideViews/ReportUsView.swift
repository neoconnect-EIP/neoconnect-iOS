//
//  ReportUsView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 08/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire

struct ReportUsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
      @State private var email : String = ""
       @State private var subject : String = ""
       @State private var message : String = ""
   @State private var type : String = ""
    @State private var selection = 1


    private var validated: Bool {
            !message.isEmpty
             }
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text("Retour utilisateur").foregroundColor(Color.white).font(.custom("Raleway", size: 20)).padding(.top, 40.0)
                HStack {
                    Text("Environnement").foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.trailing, 60.0)
                     Text("iPhone").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                }
                .padding(.top, 30.0)
                HStack {
                    Text("Type*").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                
                    Picker(selection: $selection, label: Text("Type")) {
                    Text("Bug").tag(1).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Text("Amélioration").tag(2).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Text("Commentaire").tag(3).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Text("Contact").tag(4).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    }.padding(.leading, 150.0).frame(width: 100.0, height: 50.0)
                
                }
                .padding(.top)
                    if (selection == 1 || selection == 2)
                    {
//                        TextField("Fonctionnalité*", text: $subject).padding(.top, 50.0).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        CustomTextField(placeholder: Text("Fonctionnalité*").foregroundColor(.black),text: $subject
                                                     ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.top, 50.0)
                                      Divider()
                                          .frame(width: 200.0, height: 1.0)
                                                         .background(Color(hex:"445173"))
                }
              if (selection == 3)
              {
                TextField("Commentaire*", text: $subject).padding(.top, 50.0).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
//                CustomTextField(placeholder: Text("Commentaire*").foregroundColor(.black),text: $subject
//                                                                    ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.top, 50.0)
                Divider()
                    .frame(width: 200.0, height: 1.0)
                                   .background(Color(hex:"445173"))
                }

                TextField("Message*", text: $message).foregroundColor(Color.white).frame(height: 200.0).multilineTextAlignment(.center).font(.custom("Raleway", size: 12))
//                CustomTextField(placeholder: Text("Message*").foregroundColor(.black),text: $message
//                                                                            ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).frame(height: 200.0).multilineTextAlignment(.center)
                
                Divider()
                    .frame(width: 300.0, height: 1.0)
                .background(Color(hex:"445173"))
                if (validated) {
                          Button(action:{

                            let _headers: HTTPHeaders = [
                                "Authorization": "Bearer " + accessToken  ]
                            let map = ["environnement" : "ios",
                            "type": "fonctionnalite",
                            "message": self.message] as [String : Any]
                            print(map)
                            AF.request(url+"user/feedback",
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
                                         Alert(title: Text("Nous contacter"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
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
           // .padding(.top, 20.0)
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

struct ReportUsView_Previews: PreviewProvider {
    static var previews: some View {
       // ReportUserView(idUser: 1, pseudo: "Test")
        ReportUsView()
    }
}

