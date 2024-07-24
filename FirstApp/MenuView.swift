//
//  Menu.swift
//  FirstApp
//
//  Created by Sebastian on 18/07/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination:Exercice1()){
                    Text("Figuras")
                }
                NavigationLink(destination:TextFieldExample()){
                    Text("Login")
                }
                NavigationLink(destination:IMCView()){
                    Text("IMC Calculator")
                }
                NavigationLink(destination:SuperHeroFinder()){
                    Text("Super Hero finder")
                }
                NavigationLink(destination:FavPlaces()){
                    Text("Fav places")
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
