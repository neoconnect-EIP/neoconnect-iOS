//
//  ReportUserView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 06/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire

struct ReportUserView: View {
        var userID : Int
        @State private var showingAlert = false
        @State private var pseudo : String = ""
        @State private var subject : String = ""
        @State private var message : String = ""
    private var validated: Bool {
           !pseudo.isEmpty && !subject.isEmpty && !message.isEmpty
          }
        var body: some View {
              NavigationView {
                Form {
                    Section(header:Text("Signaler un utilisateur")) {
                        TextField("Pseudo", text: $pseudo)
                        TextField("Sujet", text: $subject)
                        TextField("Message", text: $message).frame(width: 80, height: 100)
                    }
                    if (validated) {
                    Button(action: {
                        let map = ["pseudo": self.pseudo,
                                   "message": self.message,
                                   "subject": self.subject]
                        AF.request("http://168.63.65.106:8080/user/report" + String(self.userID),
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
                            Alert(title: Text("Signaler l'utilisateur"), message: Text("Message envoyé."), dismissButton: .default(Text("Ok")))
                        }
                        }
                                       else {
                                           Text("Veuillez remplir tous les champs")
                                                                           .foregroundColor(Color.red)
                                       }
                }
            .navigationBarTitle(Text("Signalement"))
            }
        }

    }

struct ReportUserView_Previews: PreviewProvider {
    static var previews: some View {
        ReportUserView(userID: 1)
    }
}
