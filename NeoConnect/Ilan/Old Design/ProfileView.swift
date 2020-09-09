//
//  ProfileView.swift
//  Neoconnect iOS
//
//  Created by Ilan Cohen on 28/02/2020.
//  Copyright © 2020 Ilan Cohen. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire

let token = UserDefaults.standard.string(forKey: "Token")!

let _headers: HTTPHeaders = [
       "Authorization": "Bearer " + token            ]


struct LoginIntegratedController: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginIntegratedController>) -> B_ConnectionPageViewController {
        return B_ConnectionPageViewController()
    }
    
    func updateUIViewController(_ uiViewController: B_ConnectionPageViewController, context: UIViewControllerRepresentableContext<LoginIntegratedController>) {
        
    }
    
}

struct ProfileView: View {
    @State private var showingDeleteAlert = false
    @State private var activateLink = false

    var body: some View {
        NavigationView {
            NavigationLink(destination: LoginIntegratedController(), isActive: $activateLink,
                               label: { Button(action: {
                                   self.showingDeleteAlert = true; }) {
                                              Text("Supprimer mon compte").foregroundColor(.red)
                               }.alert(isPresented: $showingDeleteAlert) {
                                                                   Alert(title: Text("Supprimer mon compte"), message: Text("Confirmer"), primaryButton: .destructive(Text("Supprimer")) {
                                                                       self.deleteAcc()}, secondaryButton: .cancel(Text("Annuler"))
                                                                   )
                                                               } })
            
                                
            .navigationBarTitle(Text("Profil"))
    }
    }
    func deleteAcc() {
        AF.request("http://localhost:8080/delete",
                   method: .delete,
                   encoding: URLEncoding.default,headers: _headers).response { response in
            debugPrint(response)
        }
        DispatchQueue.main.async {
            self.activateLink = true
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
