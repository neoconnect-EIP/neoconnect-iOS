//
//  I_UserLineChartsViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 26/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftUICharts
import Macaw

class I_UserLineChartsHostingController: UIHostingController<I_UserLineCharts> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: I_UserLineCharts())
    }
}

struct I_UserLineCharts: View {
    @State var data: [Double] = [100,23,54,32,12,37,7,23,43]
    
    var body: some View {
        ZStack {
            Image("InfBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        data = [100,23,54,32,12,37,7,23,43]
                    }) {
                        ZStack() {
                            Image("login")
                                .foregroundColor(Color(hex: "445173"))
                            Text("Pinterest")
                                .foregroundColor(Color.white)
                                .font(.custom("Raleway", size: 12))
                        }
                    }
                    Button(action: {
                        data = [12,113,454,192,12,37,7,23,43]
                    }) {
                        ZStack() {
                            Image("login")
                                .foregroundColor(Color(hex: "445173"))
                            Text("Instagram")
                                .foregroundColor(Color.white)
                                .font(.custom("Raleway", size: 12))
                        }
                    }
                    Button(action: {
                        data = [2,13,4554,192,32,137,7,23,43]
                    }) {
                        ZStack() {
                            Image("login")
                                .foregroundColor(Color(hex: "445173"))
                            Text("Youtube")
                                .foregroundColor(Color.white)
                                .font(.custom("Raleway", size: 12))
                        }
                    }
                }
                HStack {
                    Button(action: {
                    }) {
                        ZStack() {
                            Image("login")
                                .foregroundColor(Color(hex: "445173"))
                            Text("Twitter")
                                .foregroundColor(Color.white)
                                .font(.custom("Raleway", size: 12))
                        }
                    }
                    Button(action: {
                    }) {
                        ZStack() {
                            Image("login")
                                .foregroundColor(Color(hex: "445173"))
                            Text("Twitch")
                                .foregroundColor(Color.white)
                                .font(.custom("Raleway", size: 12))
                        }
                    }
                    Button(action: {
                    }) {
                        ZStack() {
                            Image("login")
                                .foregroundColor(Color(hex: "445173"))
                            Text("Tikto")
                                .foregroundColor(Color.white)
                                .font(.custom("Raleway", size: 12))
                        }
                    }
                }
                Spacer()
                LineView(data: data, valueSpecifier: "Followers")
                    .padding()
            }
        }
    }
}

struct I_UserLineChartsPreview: PreviewProvider {
    static var previews: some View {
        I_UserLineCharts()
    }
}

