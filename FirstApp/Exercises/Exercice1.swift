//
//  ContentView.swift
//  FirstApp
//
//  Created by Sebastian on 17/07/24.
//

import SwiftUI

struct Exercice1: View {
    var body: some View {
        VStack {
            HStack  {
                Rectangle()
                    .foregroundColor(.blue)
                Rectangle()
                    .foregroundColor(.orange)
                Rectangle()
                    .foregroundColor(.yellow)
            } .frame( height: 100)
            Rectangle()
                .foregroundColor(.orange)
                .frame(height: 100)
            HStack{
                Circle()
                    .foregroundColor(.green)
                Rectangle()
                    .frame( height: 300)
                Circle()
                    .foregroundColor(.purple)
            }
            Rectangle()
                .foregroundColor(.orange)
                .frame(height: 100)
            HStack  {
                Rectangle()
                    .foregroundColor(.blue)
                Rectangle()
                    .foregroundColor(.orange)
                Rectangle()
                    .foregroundColor(.yellow)
            } .frame( height: 100)
            
        }.background(.red)    }
}

#Preview {
    Exercice1()
}
