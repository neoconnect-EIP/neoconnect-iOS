//
//  HomePageView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 03/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import Alamofire
import Combine
import KingfisherSwiftUI

struct shopImage: Codable {
    var imageName: String?
    var imageData: String?
}

// Marques

struct Shop2: Codable,Identifiable{
    var id : Int
    var pseudo: String?
    var userPicture: [shopImage]?
    var full_name: String?
    var email: String?
    var theme: String?
    var average: Double?
    init() {
        id = 0
        pseudo = ""
        full_name = ""
        email = ""
        userPicture = [shopImage(imageName: "", imageData: "")]
        theme = ""
        average = 0.0
    }
}

struct offerImage: Codable, Hashable {
    var imageName: String?
    var imageData: String?
}

// Offres

struct Offer2: Codable,Identifiable{
    var id : Int
    var idUser: Int
    var productImg: [offerImage]?
    var productName: String?
    var productSex: String?
    var productDesc: String?
    var productSubject: String?
    var brand: String?
    var average: Double?
    var status: String?
    var createdAt: String?
    var updatedAt: String?
    init() {
        id = 0
        idUser = 0
        productName = ""
        productImg = [offerImage(imageName: "", imageData: "")]
        productSex = ""
        productDesc = ""
        productSubject = ""
        brand = ""
        average = 0.0
        status = ""
        createdAt = ""
        updatedAt = ""
    }
}
// Fil d'actualité coté Influenceurs

struct ActualityInfSide: Codable {
    var listShopNotes : [Shop2]
    var listShopPopulaire : [Shop2]
    var listShopTendance : [Shop2]
    var listOfferNotes : [Offer2]
    var listOfferPopulaire : [Offer2]
    var listOfferTendance : [Offer2]
    init()
    {
        listShopNotes = [Shop2]()
        listShopPopulaire = [Shop2]()
        listShopTendance = [Shop2]()
        listOfferNotes = [Offer2]()
        listOfferPopulaire = [Offer2]()
        listOfferTendance = [Offer2]()
    }
    
}

let url = "http://168.63.65.106:8080/"

// Obtenir le Fil d'actualité coté Influenceurs

func getActualityInfSide(completion: @escaping (ActualityInfSide) -> Void)
{
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!           ]
    var actuality: ActualityInfSide = ActualityInfSide()
    AF.request(url+"actuality", method: .get, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        let jsonString = String(data: response.data!, encoding: String.Encoding.utf8)!
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            actuality = try decoder.decode(ActualityInfSide.self, from: jsonData)
            completion(actuality)
        }
        catch
        {
            debugPrint(error)
        }
    }
}
// Savoir si une offre possède une moyenne de notes ou non, si oui l'arrondir
func isNil(offer : Offer2) -> Text
{
    if let average = offer.average {
        return Text(String(average.rounded()))
            .foregroundColor(Color.black)
            .font(.custom("Raleway", size: 12))
    }
    return Text("0").foregroundColor(Color.black)
        .font(.custom("Raleway", size: 12))
}

// Savoir si une marque possède une moyenne de notes ou non, si oui l'arrondir
func isNil2(shop : Shop2) -> Text
{
    if let average = shop.average {
        return Text(String(average.rounded()))
            .foregroundColor(Color.black)
            .font(.custom("Raleway", size: 12))
    }
    return Text("0").foregroundColor(Color.black)
        .font(.custom("Raleway", size: 12))
}

// Page d'accueil coté Inf

struct HomePageInfSideView: View {
    
    @State var actualites : ActualityInfSide
    let pseudo = UserDefaults.standard.string(forKey: "pseudo")!
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Image("logo-1")
                    
                    .padding(.top)
                    .padding(.leading, 100.0)
                
                HStack{
                    Text("Bonjour,").foregroundColor(Color.white).font(.custom("Raleway", size: 26))
                    Text(pseudo).foregroundColor(Color.white).font(.custom("Raleway", size: 26))
                }
                .padding(.top)
                
                Divider()
                    .frame(width: 82.0, height: 3.0)
                    .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                NavigationLink(destination: ActuInfSideView(actualites: actualites)) {
                    HStack{
                        Text("Fil d'actualité").foregroundColor(Color.white).font(.custom("Raleway", size: 20)).padding(.top)
                        Image("arrow")
                            .padding([.top, .leading])
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                .padding(.top)
                Divider()
                    .frame(width: 100.0, height: 1.0)
                    .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                Text("NeoConnect").foregroundColor(Color.white).font(.custom("Raleway", size: 12
                )).padding(.top, 200.0)
                
                Spacer()
            }
            .padding(.trailing, 100.0)
            .padding(.top,50)
            
        }
        
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
}
// Fil d'actualité

struct ActuInfSideView : View {
    @State var actualites : ActualityInfSide
    let pseudo = UserDefaults.standard.string(forKey: "pseudo")!
    var body: some View {
        ZStack{
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    OffersTendanceView(actualites: actualites)
                    OffersPopulairesView(actualites: actualites)
                    OffersNotesView(actualites: actualites)
                    ShopTendanceView(actualites: actualites)
                    ShopPopulaireView(actualites: actualites)
                    ShopNotesView(actualites: actualites)
                    Spacer()
                }
            }           .padding([.top, .leading])
            .padding(.top,30)
            
        }
        
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            getActualityInfSide() {response in
                self.actualites = response
            }
        }
    }
}

// Hosting Controller
class HomeViewHostingController: UIHostingController<HomePageInfSideView> {
    required init?(coder aDecoder: NSCoder) {
        let actuality : ActualityInfSide = ActualityInfSide()
        super.init(coder: aDecoder, rootView: HomePageInfSideView(actualites: actuality))
    }
}


// Offres Tendances
struct OffersTendanceView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("heart")
                Text("Offres du moment").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listOfferTendance.isEmpty) {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(actualites.listOfferTendance) { offerTendance in
                            NavigationLink(destination:DetailOffer(selectedOffer: offerTendance,date: String(offerTendance.createdAt!).components(separatedBy: "T")[0]))
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180.0, height: 137.0)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    VStack(alignment: .leading){
                                        
                                        if (offerTendance.productImg!.isEmpty) {
                                            Image("placeholder-image")
                                                .resizable().frame(width: 161.0, height: 77.0)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:offerTendance.productImg![0].imageData!))
                                                .renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                       }
                                        Text(String(offerTendance.productName ?? "Sans nom")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.bottom, 5.0)
                                        HStack{
                                            Text(String(offerTendance.productSubject ?? "Sans thème")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12))
                                                .padding(.trailing, 50.0)
                                            Text(String(offerTendance.brand ?? "Marque")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12)).bold()
                                            
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
                Text("Aucune offre actuellement").foregroundColor(Color.black)
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
// Offres Populaires

struct OffersPopulairesView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("fire")
                Text("Offres populaires").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listOfferPopulaire.isEmpty) {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(actualites.listOfferPopulaire) { offerPopulaire in
                            NavigationLink(destination:DetailOffer(selectedOffer: offerPopulaire,date: String(offerPopulaire.createdAt!).components(separatedBy: "T")[0]))
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180.0, height: 137.0)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    VStack(alignment: .leading){
                                        
                                        
                                        if (offerPopulaire.productImg!.isEmpty) {
                                            Image("placeholder-image").resizable().frame(width: 161.0, height: 77.0)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:offerPopulaire.productImg![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                        Text(String(offerPopulaire.productName ?? "Sans nom")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.bottom, 5.0)
                                        HStack{
                                            Text(String(offerPopulaire.productSubject ?? "Sans thème")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12))
                                                .padding(.trailing, 50.0)
                                            Text(String(offerPopulaire.brand ?? "Marque")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12)).bold()
                                            
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
                Text("Aucune offre actuellement").foregroundColor(Color.black)
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
// Offres les mieux notées

struct OffersNotesView : View {
    @State var actualites : ActualityInfSide = ActualityInfSide()
    
    var body: some View {
        Group{
            HStack{
                Image("Etoile")
                Text("Offres les mieux notées").foregroundColor(Color.white).font(.custom("Raleway", size: 17)).padding(.vertical)
            }
            if (!actualites.listOfferNotes.isEmpty) {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(actualites.listOfferNotes) { offerNote in
                            NavigationLink(destination:DetailOffer(selectedOffer: offerNote,date: String(offerNote.createdAt!).components(separatedBy: "T")[0]))
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180.0, height: 137.0)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    VStack(alignment: .leading){
                                        
                                        
                                        if (offerNote.productImg!.isEmpty) {
                                            Image("placeholder-image").resizable().frame(width: 161.0, height: 77.0)
                                            
                                        }
                                        else {
                                            KFImage(URL(string:offerNote.productImg![0].imageData!)).renderingMode(.original).resizable().frame(width: 161.0, height: 77.0)                                }
                                        Text(String(offerNote.productName ?? "Sans nom")).foregroundColor(Color.black)
                                            .font(.custom("Raleway", size: 12))
                                            .padding(.bottom, 5.0)
                                        HStack{
                                            Text(String(offerNote.productSubject ?? "Sans thème")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12))
                                                .padding(.trailing, 50.0)
                                            Text(String(offerNote.brand ?? "Marque")).foregroundColor(Color.black)
                                                .font(.custom("Raleway", size: 12)).bold()
                                            
                                            
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
                Text("Aucune offre actuellement").foregroundColor(Color.black)
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

let accessToken = UserDefaults.standard.string(forKey: "Token")!

// Postuler à une offre

func postulate(offer : Offer2) {
    let _headers: HTTPHeaders = [
        "Authorization": "Bearer " + accessToken            ]
    AF.request(url+"offer/apply/" + String(offer.id), method: .put, encoding: URLEncoding.default, headers: _headers) .responseString { response in
        print(response)
    }
}

// Offre détaillée

struct DetailOffer: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var rating = 0
    var selectedOffer : Offer2
    var date : String
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .center, spacing: 20.0) {
                HStack{
                    Button(action: { self.shareOffer(offer: selectedOffer)})
                    {
                        Image(systemName: "square.and.arrow.up")
                            
                            .padding(.leading, 270.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }.padding(.horizontal)
                    Button(action: { self.reportOffer(offer: selectedOffer)})
                    {
                        Image(systemName: "flag")
                            
                            .foregroundColor(.red)                    }
                }.padding(.horizontal)
                Text(String(selectedOffer.productName ?? "Sans nom")).foregroundColor(Color.white).font(.custom("Raleway", size: 20))
                if (selectedOffer.productImg!.isEmpty) {
                    Image("placeholder-image").resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                    
                }
                else if (selectedOffer.productImg!.count > 2) {
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(selectedOffer.productImg!, id: \.self) { img in
                                KFImage(URL(string:img.imageData!)).resizable().frame(width: 100, height: 100)
                                    .clipShape(Circle()).clipped().shadow(radius: 3)
                            }
                        }
                    }.padding()
                }
                else if (selectedOffer.productImg!.count == 2) {
                    HStack{
                        KFImage(URL(string:selectedOffer.productImg![0].imageData ?? " ")).renderingMode(.original).resizable().frame(width: 100, height: 100)
                            .clipShape(Circle()).clipped().shadow(radius: 3)
                        KFImage(URL(string:selectedOffer.productImg![1].imageData ?? " ")).renderingMode(.original).resizable().frame(width: 100, height: 100)
                            .clipShape(Circle()).clipped().shadow(radius: 3)
                    }
                }
                else {
                    KFImage(URL(string:selectedOffer.productImg![0].imageData!)).resizable().frame(width: 100, height: 100)
                        .clipShape(Circle()).clipped().shadow(radius: 3)
                }
                
                Text(String(selectedOffer.brand ?? "Marque")).foregroundColor(Color.white).font(.custom("Raleway", size: 16))
                Divider()
                    .frame(width: 75.0, height: 1.0)
                    .background(Color(hex: "445173"))
                Group{
                    HStack{
                        if (selectedOffer.productSubject == "Cosmétique" || selectedOffer.productSubject == "Mode")
                        {
                            Text("Sexe:").foregroundColor(Color.white).font(.custom("Raleway", size: 14))
               
                                Text(selectedOffer.productSex ?? "Unisexe").foregroundColor(Color.white).font(.custom("Raleway", size: 14))

                        }
                    }
                    
                    Text(String(selectedOffer.productDesc ?? "Pas de description")).foregroundColor(Color.white).font(.custom("Raleway", size: 12)).padding(.vertical)
                    
                    Divider()
                        .frame(width: 245.0, height: 1.0)
                        .background(Color(hex: "445173"))
                    Text(String(selectedOffer.productSubject ?? "Pas de thème renseigné")).foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                    Divider()
                        .frame(width: 75, height: 1.0)
                        .background(Color(hex: "445173"))
                }
                HStack{
                    if (selectedOffer.status == "accepted") {
                        NavigationLink(destination: ShareOfferView(selectedOffer: selectedOffer, facebook: "", twitter: "", instagram: "", pinterest: "", twitch: "", youtube: "", tiktok: "")) {
                            ZStack
                            {
                                Image("login").foregroundColor(Color(hex: "445173"))
                                
                                Text("Conclure").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }
                        }
                    }
                    else if (selectedOffer.status == "pending") {
                        Button(action: {removeApply(offer: self.selectedOffer)
                            self.showingAlert = true
                        }) {
                            ZStack
                            {
                                Image("login").foregroundColor(Color(hex: "445173"))
                                    
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                Text("Annuler").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }
                            
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Annuler ma candidature"), message: Text("Vous avez annulé votre candidature."), dismissButton: .default(Text("Ok")))
                        }
                    }
                    else
                    {
                        Button(action: {postulate(offer: self.selectedOffer)
                            self.showingAlert = true
                        }) {
                            ZStack
                            {
                                Image("login")
                                    .foregroundColor(Color(hex: "445173"))
                                Text("Postuler").foregroundColor(Color.white).font(.custom("Raleway", size: 12))
                            }                  }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Postuler à une offre"), message: Text("Vous avez postulé à cette offre."), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
                
            }.padding(.top,50)
            
        } .frame(maxWidth:.infinity,maxHeight: .infinity)
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
    func shareOffer(offer: Offer2){ // Partage d'une offre
        alertViewShare(offer:offer)
        
    }
    func reportOffer(offer: Offer2) { // Signalement d'une offre
        alertViewReport(offer:offer)
    }
}

