//
//  ContentView.swift
//  Neoconnect iOS
//
//  Created by Ilan Cohen on 16/10/2019.
//  Copyright © 2019 Ilan Cohen. All rights reserved.
//

import SwiftUI
import UIKit
import Alamofire

struct ContentView : View {
    
    var body: some View {
        NavigationView {
                  VStack {
                      NavigationLink(destination: ContactView()) {
                          Text("Contact")
                      }
                  }
              }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
