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

struct ShopTendanceView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("heart")
                Text("Boutiques du moment").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
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
                                        Image("noImage").resizable().frame(width: 161.0, height: 77.0)
                                        
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
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
    
}

struct ShopPopulaireView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("fire")
                Text("Boutiques populaires").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
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
                                        Image("noImage").resizable().frame(width: 161.0, height: 77.0)
                                        
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
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
    
}

struct ShopNotesView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("etoile")
                Text("Boutiques les mieux notées").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
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
                                        Image("noImage").resizable().frame(width: 161.0, height: 77.0)
                                        
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
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
    
}

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
                
                if (selectedShop.userPicture!.isEmpty) {
                    Image("noImage").resizable().frame(width: 100, height: 100)
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
                    Image("etoile")
                    
                    
                    
                    
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
                    NavigationLink(destination: ContactUserView(emailUser: emailUser)) {
                        ZStack
                        {
                            Image("login").foregroundColor(Color(hex: "445173"))
                            
                            Text("Contacter").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                        }                      }
                    
                }
                
            }
            .padding(.top,50)
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
}
struct DetailShopView_Previews: PreviewProvider {
    static var previews: some View {
        let shop : Shop2 = Shop2()
        return DetailShopView(selectedShop: shop, emailUser: "test", userId: 2)
    }
}


