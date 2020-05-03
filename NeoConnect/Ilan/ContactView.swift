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
    
    @State private var email = ""
    @State private var subject = ""
    @State private var message = ""
    
    var body: some View {
          NavigationView {
            Form {
                Section(header:Text("Nous contacter")) {
                    TextField("Email", text: $email)
                    TextField("Sujet", text: $subject)
                    TextField("Message", text: $message).frame(width: 80, height: 100)
                }
                Button(action: {
                    let map = ["email": self.$email, "subject": self.$subject, "message": self.$message]
                    AF.request("http://168.63.65.106/contact",
                               method: .post,
                               parameters: map,
                               encoding: URLEncoding.default).response { response in
                        debugPrint(response)
                    }
                }) {
                        Text("Envoyer")
                }
            }
        .navigationBarTitle(Text("Contact"))
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
