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
        VStack(alignment: .center, spacing: 20.0) {
           Image("jean").resizable().frame(width: 100, height: 100)
            .clipShape(Circle()).clipped().padding(10)
            .shadow(radius: 3)
            Text("AIR JORDAN XX9 LA MEILLEURE CHAUSSURE DE BASKETBALL AU MONDE").multilineTextAlignment(.center).padding(10).font(.headline)

            HStack() {
            Text("Pas de thème renseigné").font(.subheadline).fontWeight(.light).multilineTextAlignment(.leading)
                .padding(.trailing,30)
            Text("Male").font(.subheadline).fontWeight(.light).multilineTextAlignment(.leading)
                .padding(.trailing,30)
            }
            Divider()
                .padding(.trailing,50)
                .padding(.leading,50)
                
            Text("Alors à la pointe de l'innovation depuis près de trois décennies, la marque Jordan repousse à nouveau les limites avec la Air Jordan XX9, la toute première chaussure de basketball tissée. S'inspirant de la confection italienne").font(.body).fontWeight(.light).multilineTextAlignment(.center)


            Text("Crée le 2020-05-08T15:53:31.474Z")
                .foregroundColor(Color.gray).italic()
              
            .font(Font.system(size: 14))
            Button(action: {print("yo")}) {
                Text("Postuler")
                    .foregroundColor(Color.blue)
            }.padding(20)
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
