//
//  HomeView.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            OffersView()
    .tabItem {
                      Image("Home")
                     Text("Accueil")
                 }
             MyOffersView()
                 .tabItem {
                     Image("Search")
                     Text("Recherche")
                 }
             Text("Chat View")
                 .tabItem {
                     Image("Chat")
                     Text("Messagerie")
                 }
ContactView()
    .tabItem {
                            Image("Profil")
                            Text("Profil")
                        }
         }    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
