//
//  ContactView.swift
//  Neoconnect iOS
//
//  Created by Ilan Cohen on 26/10/2019.
//  Copyright © 2019 Ilan Cohen. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire

struct ContactView: View {
    @State private var showingAlert = false
    @State private var email : String = ""
    @State private var subject : String  = ""
    @State private var message : String = ""
    @State private var emailString  : String = ""
    @State private var isEmailValid : Bool   = true
    private var validated: Bool {
               !email.isEmpty && !subject.isEmpty && !message.isEmpty
           }
    
    var body: some View {
          NavigationView {
            Form {
                Section(header:Text("Nous contacter")) {
                    TextField("Email", text: $email, onEditingChanged: { (isChanged) in
                    if !isChanged {
                        if self.textFieldValidatorEmail(self.email) {
                            self.isEmailValid = true
                        } else {
                            self.isEmailValid = false
                            self.email = ""
                        }
                        }})
                    if !self.isEmailValid {
                               Text("Adresse invalide")
                                   .font(.callout)
                                   .foregroundColor(Color.red)
                           }
                    TextField("Sujet", text: $subject)
                    TextField("Message", text: $message).frame(width: 80, height: 100)
                }
                if (validated && self.isEmailValid) {
                Button(action: {
                    let map = ["email": self.email, "subject": self.subject, "message": self.message]
                    AF.request("http://168.63.65.106/contact",
                               method: .post,
                               parameters: map,
                               encoding: URLEncoding.default).response { response in
                        debugPrint(response)
                    }
                    self.showingAlert = true
                }) {
                        Text("Envoyer")
                }
                    .alert(isPresented: $showingAlert) {
                                           Alert(title: Text("Nous contacter"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
                                       }
                    }
                                   else {
                                       Text("Veuillez remplir tous les champs")
                                                                       .foregroundColor(Color.red)
                                   }
            }
        .navigationBarTitle(Text("Contact"))
        }
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

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
