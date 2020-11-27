//
//  I_UserLineChartsViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Combine
import SwiftUI
import SwiftUICharts

class I_UserLineChartsHostingController: UIHostingController<I_UserLineCharts> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: I_UserLineCharts())
    }
}

struct Social: Decodable {
    var id: Int
    var social: String
    var value: [Double]
    var date: [String]
    
    init(id: Int, social: String, value: [Double], date: [String]) {
        self.id = id
        self.social = social
        self.value = value
        self.date = date
    }
}

struct SocialList: Decodable {
  var results: [Social]
}

class NetworkManager: ObservableObject {
    var objectWillChange = PassthroughSubject<NetworkManager, Never>()
    var socials = SocialList(results: []){
        didSet {
            objectWillChange.send(self)
        }
      }
    
    init() {
        getDataFromAPI()
        print(socials)
    }
    
    private func getDataFromAPI() {
        APIInfManager.sharedInstance.getInfo(onSuccess: { response in
            DispatchQueue.main.async {
                self.socials = self.createArray(social: response)
            }
        })
    }
    
    private func createArray(social: [String:Any]) -> SocialList {
        var socials = SocialList(results: [])
        
        if let twitchNb = social["twitchNb"] as? [Double] {
            let twitch = social["twitch"] as? String ?? ""
            var twitchValues: [Double] = []
            var twitchDate: [String] = []
            if let twitchUpdateDate = social["twitchUpdateDate"] as? [String] {
                for date in twitchUpdateDate {
                    twitchDate.append(date)
                }
            }
            for value in twitchNb {
                twitchValues.append(value)
            }
            socials.results.append(Social(id: 0, social: twitch, value: twitchValues, date: twitchDate))
            print(socials)
        }
        if let twitterNb = social["twitterNb"] as? [Double] {
            let twitter = social["twitter"] as? String ?? ""
            var twitterValues: [Double] = []
            var twitterDate: [String] = []
            if let twitterUpdateDate = social["twitterUpdateDate"] as? [String] {
                for date in twitterUpdateDate {
                    twitterDate.append(date)
                }
            }
            for value in twitterNb {
                twitterValues.append(value)
            }
            socials.results.append(Social(id: 1, social: twitter, value: twitterValues, date: twitterDate))
        }
        if let tiktokNb = social["tiktokNb"] as? [Double] {
            let tiktok = social["tiktok"] as? String ?? ""
            var tiktokValues: [Double] = []
            var tiktokDate: [String] = []
            if let tiktokUpdateDate = social["tiktokUpdateDate"] as? [String] {
                for date in tiktokUpdateDate {
                    tiktokDate.append(date)
                }
            }
            for value in tiktokNb {
                tiktokValues.append(value)
            }
            socials.results.append(Social(id: 2, social: tiktok, value: tiktokValues, date: tiktokDate))
        }
        
        return socials
    }
}

struct I_UserLineCharts: View {
    @State var values: [Double]!
    @State var date: [String]!
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        ZStack {
            Image("InfBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    ForEach(networkManager.socials.results, id: \.id) { social in
                        if social.value.count > 0 {
                            Button(action: {
                                values = social.value
                                date = social.date
                            }) {
                                ZStack() {
                                    Image("login")
                                        .foregroundColor(Color(hex: "445173"))
                                    Text(social.social)
                                        .foregroundColor(Color.white)
                                        .font(.custom("Raleway", size: 12))
                                }
                            }
                        }
                    }
                }
                Spacer()
                if values != nil {
                    LineView(data: values)
                        .padding()
                }
            }
        }
    }
}

struct I_UserLineChartsPreview: PreviewProvider {
    static var previews: some View {
        I_UserLineCharts()
    }
}

