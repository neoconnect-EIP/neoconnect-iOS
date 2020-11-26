//
//  DetailShopView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 06/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire
import Combine
import KingfisherSwiftUI

// Marques Tendances

struct ShopTendanceView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("heart")
                Text("Marques du moment").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listShopTendance.isEmpty) {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(actualites.listShopTendance) { shopTendance in
                            NavigationLink(destination: DetailShopView(selectedShop: shopTendance, emailUser: shopTendance.email!, userId: shopTendance.id))
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180.0, height: 137.0)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    VStack(alignment: .leading){
                                        
                                        
                                        if (shopTendance.userPicture!.isEmpty) {
                                            Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:shopTendance.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                        Text(String(shopTendance.pseudo!)).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.bottom, 5.0)
                                        HStack{
                                            Text(String(shopTendance.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12))
                                                .padding(.trailing, 50.0)
                                            HStack{
                                                isNil2(shop: shopTendance)
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
                Text("Aucune marque actuellement").foregroundColor(Color.black)
                    .font(.custom("Raleway", size: 12)).italic()
            }
        }
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
    
}
// Marques Populaires
struct ShopPopulaireView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("fire")
                Text("Marques populaires").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listShopPopulaire.isEmpty) {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(actualites.listShopPopulaire) { shopPopulaire in
                            NavigationLink(destination: DetailShopView(selectedShop: shopPopulaire, emailUser: shopPopulaire.email!, userId: shopPopulaire.id))
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180.0, height: 137.0)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    VStack(alignment: .leading){
                                        
                                        
                                        if (shopPopulaire.userPicture!.isEmpty) {
                                            Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:shopPopulaire.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                        Text(String(shopPopulaire.pseudo!)).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.bottom, 5.0)
                                        HStack{
                                            Text(String(shopPopulaire.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12))
                                                .padding(.trailing, 50.0)
                                            HStack{
                                                isNil2(shop: shopPopulaire)
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
                Text("Aucune marque actuellement").foregroundColor(Color.black)
                    .font(.custom("Raleway", size: 12)).italic()
            }
        }
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
    
}
// Marques les mieux notées
struct ShopNotesView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("Etoile")
                Text("Marques les mieux notées").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listShopNotes.isEmpty) {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(actualites.listShopNotes) { shopNote in
                            NavigationLink(destination: DetailShopView(selectedShop: shopNote, emailUser: shopNote.email!, userId: shopNote.id))
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180.0, height: 137.0)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    VStack(alignment: .leading){
                                        
                                        
                                        if (shopNote.userPicture!.isEmpty) {
                                            Image("avatar-placeholder").resizable().frame(width: 161.0, height: 77.0)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:shopNote.userPicture![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                        Text(String(shopNote.pseudo!)).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.bottom, 5.0)
                                        HStack{
                                            Text(String(shopNote.theme ?? "Pas de thème renseigné")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12))
                                                .padding(.trailing, 50.0)
                                            HStack{
                                                isNil2(shop: shopNote)
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
                Text("Aucune marque actuellement").foregroundColor(Color.black)
                    .font(.custom("Raleway", size: 12)).italic()
            }
        }
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
    
}

// Marque détaillée
struct DetailShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var rating = 0
    var selectedShop : Shop2
    var emailUser : String
    var userId : Int
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 20.0) {
                Button(action: { self.reportUser()})
                {
                    Image(systemName: "flag")
                        .padding(.leading, 300.0)
                        .foregroundColor(.red)                    }
                if (selectedShop.userPicture!.isEmpty) {
                    Image("avatar-placeholder").resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                    
                }
                else {
                    KFImage(URL(string:selectedShop.userPicture![0].imageData!)).resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                }
                Text(String(selectedShop.pseudo!)).foregroundColor(Color.white).font(.custom("Raleway", size: 24))
                
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
                    Text(String(selectedShop.theme ?? "Pas de thème renseigné")).fontWeight(.medium).foregroundColor(Color.white).font(.custom("Raleway", size: 18)).padding(.trailing, 100.0)
                    Text(String(selectedShop.average?.rounded() ?? 0)).foregroundColor(Color.white).font(.custom("Raleway", size: 18)).padding(.vertical)
                    Image("Etoile")
                    
                    
                    
                    
                }
                HStack{
                    NavigationLink(destination: NotationUserView(userId: userId, rating: rating)) {
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
                                
                                Text("Contacter par mail").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        }                      }
                    Button(action: { self.sendMessage()})
                    {
                        ZStack
                        {
                            Image("login").foregroundColor(Color(hex: "445173"))
                            
                            Text("Contacter").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        }
                    }
                    
                }
                
            }
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
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
    func reportUser(){ // Signalement d'une marque
        
        let alertController = UIAlertController(title: "Signaler une marque", message: "Veuillez indiquer le motif de votre signalement", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Motif"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let motif = alertController.textFields![0].text!
            
            let map = [ "pseudo" : selectedShop.pseudo!,
                        "subject": "Marque",
                        "message": motif]
            AF.request(url+"user/report/" + String(selectedShop.id),
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
    
    func sendMessage(){ // Envoi d'un message à une marque
        
        let alertController = UIAlertController(title: "Envoyer un message", message: "Veuillez indiquer votre message à envoyer", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Message"
        }
        let saveAction = UIAlertAction(title: "Envoyer", style: .default, handler: { alert -> Void in
            let _headers: HTTPHeaders = [
                "Authorization": "Bearer " + accessToken
            ]
            let message = alertController.textFields![0].text!
            
            let map = [ "userId" : selectedShop.id,
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
struct DetailShopView_Previews: PreviewProvider {
    static var previews: some View {
        let shop : Shop2 = Shop2()
        return DetailShopView(selectedShop: shop, emailUser: "test", userId: 2)
    }
}

//
//struct I_ChatViewControllerWrapper: UIViewControllerRepresentable {
//    var user_id : Int
//    var pseudo : String
//    var image: UIImage
//    typealias UIViewControllerType = I_DetailedChatViewController
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<I_ChatViewControllerWrapper>) -> I_ChatViewControllerWrapper.UIViewControllerType {
//
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "I_Chat", bundle: nil)
//        let mainViewController: I_DetailedChatViewController = mainStoryboard.instantiateViewController(withIdentifier: "MessageViewInf") as! I_DetailedChatViewController
//        mainViewController.shop = Shop(id: UserDefaults.standard.integer(forKey: "id"), user_id: user_id, pseudo: pseudo, image: image)
//        return mainViewController
//
//    }
//
//    func updateUIViewController(_ uiViewController: I_ChatViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<I_ChatViewControllerWrapper>) {
//
//    }
//}
//
////                    NavigationLink(destination: I_ChatViewControllerWrapper(user_id: selectedShop.id, pseudo: selectedShop.pseudo ?? "Pseudo", image: #imageLiteral(resourceName: "avatar-placeholder"))) {
////                        ZStack
////                            {
////                                Image("login").foregroundColor(Color(hex: "445173"))
////
////                                Text("Contacter").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
////                        }                      }
