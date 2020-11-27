//
//  DetailInfView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 07/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire
import Combine
import KingfisherSwiftUI

struct infImage: Codable {
    var imageName: String?
    var imageData: String?
}

// Influenceur
struct Inf2: Codable,Identifiable{
    var id : Int
    var pseudo: String?
    var userPicture: [infImage]?
    var full_name: String?
    var email: String?
    var theme: String?
    var average: Double?
    init() {
        id = 0
        pseudo = ""
        full_name = ""
        email = ""
        userPicture = [infImage(imageName: "", imageData: "")]
        theme = ""
        average = 0.0
    }
}

// Fil d'actualité
struct ActualityShopSide: Codable {
    var listInfNotes : [Inf2]
    var listInfPopulaire : [Inf2]
    var listInfTendance : [Inf2]
    
    init()
    {
        listInfNotes = [Inf2]()
        listInfPopulaire = [Inf2]()
        listInfTendance = [Inf2]()
    }
    
}

// Obtenir le fil d'actu
func getActualityShopSide(completion: @escaping (ActualityShopSide) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!           ]
    var actuality: ActualityShopSide = ActualityShopSide()
    AF.request(url+"actuality", method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            actuality = try decoder.decode(ActualityShopSide.self, from: jsonData)
            completion(actuality)
        }
        catch
        {
            debugPrint(error)
        }
    }
}

// Obtenir les suggestions d'influenceurs
func getSuggestionInfShopSide(completion: @escaping ([Inf2]) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!           ]
    var inf: [Inf2] = [Inf2]()
    AF.request(url+"user/suggestion", method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            inf = try decoder.decode([Inf2].self, from: jsonData)
            completion(inf)
        }
        catch
        {
            debugPrint(error)
        }
    }
}

// Suggestions d'influenceurs
struct InfSuggestionView : View {

    @State var ListInf : [Inf2]

    var body: some View {
        Group{
            HStack{
                Image(systemName: "lightbulb").foregroundColor(.yellow)
                Text("Dans votre thème").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(ListInf) { inf in
                        NavigationLink(destination: DetailInfView(selectedInf: inf, emailUser: inf.email!, userId: inf.id))
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 180.0, height: 137.0)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                VStack(alignment: .leading){
                                    
                                    
                                    if (inf.userPicture!.isEmpty) {
                                        Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                        
                                    }
                                    else {
                                        KFImage(URL(string:inf.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                    Text(String(inf.pseudo!)).foregroundColor(Color.black)
                                        .font(.custom("Raleway", size: 12))
                                        .padding(.bottom, 5.0)
                                    HStack{
                                        Text(String(inf.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.trailing, 50.0)
                                        HStack{
                                            isNil3(inf: inf)
                                            Image(systemName: "star.fill").foregroundColor(.yellow)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                } .frame(width: 180.0, height: 137.0)
                                
                                
                            }.frame(width: 180.0, height: 137.0).foregroundColor(.white)
                        }
                        
                    }
                    
                    
                }
            }
            
        }
            
        .onAppear {
            
            getSuggestionInfShopSide() {response in
                self.ListInf = response
            }
        }
        
    }
    
}

// Influenceurs tendances
struct InfTendanceView : View {
    @State var actualites : ActualityShopSide
    var body: some View {
        Group{
            HStack{
                Image("heart")
                Text("Influenceurs du moment").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listInfTendance.isEmpty) {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(actualites.listInfTendance) { infTendance in
                        NavigationLink(destination: DetailInfView(selectedInf: infTendance, emailUser: infTendance.email!, userId: infTendance.id))
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 180.0, height: 137.0)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                VStack(alignment: .leading){
                                    
                                    
                                    if (infTendance.userPicture!.isEmpty) {
                                        Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                        
                                    }
                                    else {
                                        KFImage(URL(string:infTendance.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                    Text(String(infTendance.pseudo ?? "Pas de pseudo")).foregroundColor(Color.black)
                                        .font(.custom("Raleway", size: 12))
                                        .padding(.bottom, 5.0)
                                    HStack{
                                        Text(String(infTendance.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.trailing, 50.0)
                                        HStack{
                                            isNil3(inf: infTendance)
                                            Image(systemName: "star.fill").foregroundColor(.yellow)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                } .frame(width: 180.0, height: 137.0)
                                
                                
                            }.frame(width: 180.0, height: 137.0).foregroundColor(.white)
                        }
                        
                    }
                    
                    
                }
            }
            
        }
            else
            {
                Text("Aucun influenceur actuellement").foregroundColor(Color.black)
                    .font(.custom("Raleway", size: 12)).italic()
            }
        }
        .onAppear {
            
            getActualityShopSide() {response in
                self.actualites = response
            }
        }
        
    }
    
}
// Influenceurs populaires
struct InfPopulaireView : View {
    @State var actualites : ActualityShopSide = ActualityShopSide()
    
    var body: some View {
        Group{
            HStack{
                Image("fire")
                Text("Influenceurs populaires").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listInfPopulaire.isEmpty) {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(actualites.listInfPopulaire) { infPopulaire in
                        NavigationLink(destination: DetailInfView(selectedInf: infPopulaire, emailUser: infPopulaire.email!, userId: infPopulaire.id))
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 180.0, height: 137.0)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                VStack(alignment: .leading){
                                    
                                    
                                    if (infPopulaire.userPicture!.isEmpty) {
                                        Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                        
                                    }
                                    else {
                                        KFImage(URL(string:infPopulaire.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                    Text(String(infPopulaire.pseudo ?? "Pas de pseudo")).foregroundColor(Color.black)
                                        .font(.custom("Raleway", size: 12))
                                        .padding(.bottom, 5.0)
                                    HStack{
                                        Text(String(infPopulaire.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.trailing, 50.0)
                                        HStack{
                                            isNil3(inf: infPopulaire)
                                            Image(systemName: "star.fill").foregroundColor(.yellow)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                } .frame(width: 180.0, height: 137.0)
                                
                                
                            }.frame(width: 180.0, height: 137.0).foregroundColor(.white)
                        }
                        
                    }
                    
                    
                }
            }
            
        }
            else
            {
                Text("Aucun influenceur actuellement").foregroundColor(Color.black)
                    .font(.custom("Raleway", size: 12)).italic()
            }
        }
        .onAppear {
            getActualityShopSide() {response in
                self.actualites = response
            }
        }
    }
    
}
// Influenceurs les mieux notés
struct InfNotesView : View {
    @State var actualites : ActualityShopSide = ActualityShopSide()
    
    var body: some View {
        Group{
            HStack{
                Image("Etoile")
                Text("Influenceurs les mieux notés").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listInfNotes.isEmpty) {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(actualites.listInfNotes) { infNote in
                        NavigationLink(destination: DetailInfView(selectedInf: infNote, emailUser: infNote.email!, userId: infNote.id))
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 180.0, height: 137.0)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                VStack(alignment: .leading){
                                    
                                    
                                    if (infNote.userPicture!.isEmpty) {
                                        Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                        
                                    }
                                    else {
                                        KFImage(URL(string:infNote.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                    Text(String(infNote.pseudo ?? "Pas de pseudo")).foregroundColor(Color.black)
                                        .font(.custom("Raleway", size: 12))
                                        .padding(.bottom, 5.0)
                                    HStack{
                                        Text(String(infNote.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.trailing, 50.0)
                                        HStack{
                                            isNil3(inf: infNote)
                                            Image(systemName: "star.fill").foregroundColor(.yellow)
                                        }
                                    }
                                    
                                    
                                    
                                } .frame(width: 180.0, height: 137.0)
                                
                                
                            }.frame(width: 180.0, height: 137.0).foregroundColor(.white)
                        }
                        
                    }
                    
                    
                }
            }
            
        }
            else
            {
                Text("Aucun influenceur actuellement").foregroundColor(Color.black)
                    .font(.custom("Raleway", size: 12)).italic()
            }
        }
        .onAppear {
            getActualityShopSide() {response in
                self.actualites = response
            }
        }
    }
    
}
// Page influenceur détaillée
struct DetailInfView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var rating = 0
    var selectedInf : Inf2
    var emailUser : String
    var userId : Int
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 20.0) {
                Button(action: { self.reportUser()})
                {
                    Image(systemName: "flag")
                        .padding(.leading, 300.0)
                        .foregroundColor(.red)
                }
                if (selectedInf.userPicture!.isEmpty) {
                    Image("avatar-placeholder").resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                    
                }
                else {
                    KFImage(URL(string:selectedInf.userPicture![0].imageData!)).resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                }
                Text(String(selectedInf.pseudo!)).foregroundColor(Color.white).font(.custom("Raleway", size: 24))
                
                Divider()
                    .frame(width: 75.0, height: 1.0)
                    .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text("Thème")
                        .fontWeight(.light)
                        .italic()
                        .padding(.trailing, 100.0)
                    Text("Note")
                        .fontWeight(.light)
                        .italic()
                }
                HStack{
                    Text(String(selectedInf.theme ?? "Pas de thème renseigné")).fontWeight(.medium).foregroundColor(Color.white).font(.custom("Raleway", size: 18)).padding(.trailing, 100.0)
                    Text(String(selectedInf.average?.rounded() ?? 0)).foregroundColor(Color.white).font(.custom("Raleway", size: 18)).padding(.vertical)
                    Image("Etoile")
                    
                    
                    
                    
                }
                HStack{
                    NavigationLink(destination: NotationUserShopSideView(userId: userId, rating: rating)) {
                        ZStack
                            {
                                Image("login")
                                    .foregroundColor(Color(hex: "445173"))
                                Text("Noter").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        }
                    }
                    NavigationLink(destination: ContactUserShopSideView(emailUser: emailUser)) {
                        ZStack
                            {
                                Image("login").foregroundColor(Color(hex: "445173"))
                                
                                Text("Mail").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        }                      }
                    Button(action: { self.sendMessage()})
                    {
                        ZStack
                        {
                            Image("login").foregroundColor(Color(hex: "445173"))
                            
                            Text("Message").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        }
                    }
                    
                }
                
            }            
        } .frame(maxWidth:.infinity,maxHeight: .infinity)
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
func reportUser() { // Signalement d'un influenceur
    DispatchQueue.main.async {

        let alertController = UIAlertController(title: "Signaler un influenceur", message: "Veuillez indiquer le motif de votre signalement", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Motif"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let motif = alertController.textFields![0].text!
            
            let map = [ "pseudo" : selectedInf.pseudo!,
                        "subject": "Influenceur",
                        "message": motif]
            AF.request(url+"user/report/" + String(selectedInf.id),
                       method: .post,
                       parameters: map as Parameters,
                       encoding: URLEncoding.default,headers: _headers).response { response in
                        debugPrint(response)
                       }
            
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
        
    }
    func sendMessage(){ // Envoi d'un message à un Influenceur
        DispatchQueue.main.async {

        let alertController = UIAlertController(title: "Envoyer un message", message: "Veuillez indiquer votre message à envoyer", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Message"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let message = alertController.textFields![0].text!
            
            let map = [ "userId" : selectedInf.id,
                        "message": message] as [String : Any]
            AF.request(url+"message",
                       method: .post,
                       parameters: map as Parameters,
                       encoding: URLEncoding.default,headers: _headers).response { response in
                        debugPrint(response)
                       }
            
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        }
    }
}
struct DetailInfView_Previews: PreviewProvider {
    static var previews: some View {
        let inf : Inf2 = Inf2()
        return DetailInfView(selectedInf: inf, emailUser: "test", userId: 2)
    }
}
