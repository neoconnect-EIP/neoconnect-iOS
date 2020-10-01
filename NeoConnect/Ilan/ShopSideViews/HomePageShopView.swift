//
//  HomePageShopView.swift
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

func isNil3(inf : Inf2) -> Text
{
    if let average = inf.average {
        return Text(String(average.rounded()))
                                                                       .foregroundColor(Color.black)
                                                                        .font(.custom("Raleway", size: 12))
                                  }
    return Text("0").foregroundColor(Color.black)
                                                                               .font(.custom("Raleway", size: 12))
}
struct ActuShopSideView : View {
      @State var actualites : ActualityShopSide
        let pseudo = UserDefaults.standard.string(forKey: "pseudo")!
          var body: some View {
            ZStack{
                 ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .leading) {
                   
                    InfTendanceView(actualites: actualites)
                    InfPopulaireView(actualites: actualites)
                    InfNotesView(actualites: actualites)
                    Spacer()
                    }
                }           .padding([.top, .leading])

    }

            .frame(maxWidth:.infinity,maxHeight: .infinity)
                                  .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "16133C").opacity(0.95), Color(hex: "048136").opacity(0.1)]), startPoint: .top, endPoint: .bottom))
           .onAppear {
                            getActualityShopSide() {response in
                                self.actualites = response
                    }
    }
        }
}
struct HomePageShopSideView: View {

    @State var actualites : ActualityShopSide
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
                    NavigationLink(destination: ActuShopSideView(actualites: actualites)) {
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
                    Text("NeoConnect Beta").foregroundColor(Color.white).font(.custom("Raleway", size: 12
                        )).padding(.top, 200.0)
                       
Spacer()
            }
            .padding(.trailing, 100.0)
                

}

        .frame(maxWidth:.infinity,maxHeight: .infinity)
                       .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "16133C").opacity(0.95), Color(hex: "048136").opacity(0.1)]), startPoint: .top, endPoint: .bottom))
       .onAppear {
                        getActualityShopSide() {response in
                            self.actualites = response
                }
}
    }
}


struct HomePageShopView_Previews: PreviewProvider {
    static var previews: some View {
        let actuality : ActualityShopSide = ActualityShopSide()
        return HomePageShopSideView(actualites: actuality)
    }
}

class HomeShopViewHostingController: UIHostingController<HomePageShopSideView> {
    required init?(coder aDecoder: NSCoder) {
        let actuality : ActualityShopSide = ActualityShopSide()
        super.init(coder: aDecoder, rootView: HomePageShopSideView(actualites: actuality))
        super.viewWillAppear(true)
    }
}
