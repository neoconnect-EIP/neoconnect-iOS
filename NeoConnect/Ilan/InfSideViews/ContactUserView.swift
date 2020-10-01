//
//  ContactUserView.swift
//  Neoconnect iOS
//
//  Created by Ilan Cohen on 28/02/2020.
//  Copyright © 2020 Ilan Cohen. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire

struct ContactUserView: View {
    @State private var showingAlert = false
    @State var emailUser : String
    @State private var subject : String = ""
    @State private var message : String = ""
    @State private var emailString  : String = ""
    @State private var isEmailValid : Bool   = true
    private var validated: Bool {
               !emailUser.isEmpty && !subject.isEmpty && !message.isEmpty
             }
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text("Contacter").foregroundColor(Color.white).font(.custom("Raleway", size: 20)).padding(.top, 50.0).padding(.leading, 100.0)
                      TextField("Email", text: $emailUser, onEditingChanged: { (isChanged) in
                             if !isChanged {
                                 if self.textFieldValidatorEmail(self.emailUser) {
                                     self.isEmailValid = true
                                 } else {
                                     self.isEmailValid = false
                                     self.emailUser = ""
                                 }
                                 }}).frame(width: 150.0, height: 50.0).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                             if !self.isEmailValid {
                                        Text("Adresse invalide")
                                         .foregroundColor(Color.red)
                                            .font(.custom("Raleway", size: 15))
                                    }
                Divider()
                                   .frame(width: 200.0, height: 1.0)
                                   .background(Color(hex:"445173"))
                TextField("Sujet*", text: $subject).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                Divider()
                    .frame(width: 200.0, height: 1.0)
                                   .background(Color(hex:"445173"))
                TextField("Message*", text: $message).foregroundColor(Color.white).frame(height: 200.0).multilineTextAlignment(.center).font(.custom("Raleway", size: 12))
                
                Divider()
                    .frame(width: 300.0, height: 1.0)
                .background(Color(hex:"445173"))
                if (validated && self.isEmailValid) {
                    Button(action: {
                                 let map = ["to": self.emailUser,
                                            "email": self.emailUser,
                                            "subject": self.subject, "message": self.message]
                                 AF.request(url+"user/contact",
                                            method: .post,
                                            parameters: map,
                                            encoding: URLEncoding.default).response { response in
                                     debugPrint(response)
                                 }
                                 self.showingAlert = true
                                 
                             }) {
                                     Image("icons8-envoi-de-courriel-24")
                                                                    .frame(width: 50.0, height: 50.0)
                                                                      .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)                             }
                                     .alert(isPresented: $showingAlert) {
                                     Alert(title: Text("Contacter l'utilisateur"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
                                 }
                                 .frame(width: 300.0)
                                                          .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }
                          else {
                              Text("Veuillez remplir tous les champs")
                                .foregroundColor(Color.red)
                                .padding(.top)
                    .font(.custom("Raleway", size: 15))
                                
                          }
                Spacer()
            }
            .padding(.top, 20.0)
            .frame(width: 300.0)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))

    }
     func textFieldValidatorEmail(_ string: String) -> Bool {
            if string.count > 100 {
                return false
            }
            let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: string)
        }

}

struct ContactUserView_Previews: PreviewProvider {
    static var previews: some View {
       // ReportUserView(idUser: 1, pseudo: "Test")
        ContactUserView(emailUser: "Email")
    }
}
