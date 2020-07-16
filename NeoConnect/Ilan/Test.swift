//
//  Test.swift
//  NeoConnect
//
//  Created by Ilan Cohen on 09/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI

struct Test: View {
    var body: some View {
        VStack(spacing: 50.0) {
            Text("Envoyer un email").foregroundColor(Color.white).multilineTextAlignment(.leading).padding(10).font(.custom("Raleway", size: 20))
            VStack(alignment: .leading, spacing: 20.0) {
                Text("Email*").foregroundColor(Color.white).padding(10).font(.custom("Raleway", size: 12))
                Divider()
                    .frame(width: 200.0, height: 1.0)
                    .background(Color(hex:"445173"))
                Text("Sujet*").foregroundColor(Color.white).padding(10).font(.custom("Raleway", size: 12))
                Divider()
                    .padding(30.0)
                    .frame(width: 200.0, height: 1.0)
                                   .background(Color(hex:"445173"))
                Text("Message*").foregroundColor(Color.white).multilineTextAlignment(.center).lineLimit(20).padding(.vertical, 150.0).padding(.leading, 80).font(.custom("Raleway", size: 12))
                Divider()
                    .frame(width: 200.0, height: 1.0)
                .background(Color(hex:"445173"))
                    
            }
            .frame(width: 370.0, height: 500.0)
            Button(action:{ print("yo")}) {
                Image("icons8-envoi-de-courriel-24")
                    .frame(width: 50.0, height: 50.0)
                    
                
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)

        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "15113D").opacity(0.85), Color(hex: "3CA6CC").opacity(0.5)]), startPoint: .top, endPoint: .bottom))

    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}
