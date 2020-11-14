//
//  ReportUserView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 16/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire

// Signaler un utilisateur

struct ReportUserView: View {
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
        
                CustomTextField(placeholder: Text("Pseudo*").foregroundColor(.black),
                                text: $pseudo
                ).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).frame(width: 150.0, height: 50.0)
                Divider()
                    .frame(width: 200.0, height: 1.0)
                    .background(Color(hex:"445173"))
                CustomTextField(placeholder: Text("Sujet*").foregroundColor(.black),text: $subject
                ).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
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

struct ReportUserView_Previews: PreviewProvider {
    static var previews: some View {
        ReportUserView(idUser: 1, pseudo: "Test")
    }
}

// Gérer les couleurs radientes
extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }
        
        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }
        
        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }
        
        // Scanner creation
        let scanner = Scanner(string: string)
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        if string.count == 2 {
            let mask = 0xFF
            
            let g = Int(color) & mask
            
            let gray = Double(g) / 255.0
            
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
            
        } else if string.count == 4 {
            let mask = 0x00FF
            
            let g = Int(color >> 8) & mask
            let a = Int(color) & mask
            
            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0
            
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
            
        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
            
        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask
            
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0
            
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
            
        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}

// Texte personnalisé
struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}
