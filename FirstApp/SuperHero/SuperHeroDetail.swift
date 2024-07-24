//
//  SuperHeroDetail.swift
//  FirstApp
//
//  Created by Sebastian on 21/07/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

struct SuperHeroDetail: View {
    let id:String
    @State var superhero:ApiNetwork.SuperheroDetail? = nil
    @State var isLoading:Bool = true
    
    var body: some View {
        VStack{
            if isLoading {
                ProgressView().tint(.white)
            }else if let superhero = superhero {
                WebImage(url: URL(string: superhero.image.url))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                
                Text(superhero.name).font(.title).bold()
                
                ForEach(superhero.biography.aliases, id: \.self){ alise in
                    Text(alise).italic()
                }
                
                Spacer()
                
                SuperHeroChart(stats: superhero.powerstats)
                
            }else{
                Text("No hay resultados")
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
        .onAppear{
            Task{
                do{
                    superhero = try await ApiNetwork().getSuperheroById(id: id)
                }catch{
                    print("Error")
                }
                isLoading = false
            }
        }
    }
}



struct SuperHeroChart:View {
    let stats:ApiNetwork.PowerStats
    
    var body: some View {
        Chart{
            SectorMark(
                angle: .value("Count", Int(stats.combat) ?? 0),
                innerRadius: .ratio(0.6), 
                angularInset: 5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", "Combat"))
            
            SectorMark(
                angle: .value("Count", Int(stats.durability) ?? 0),
                innerRadius: .ratio(0.6),
                angularInset: 5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", "Durability"))
            
            SectorMark(
                angle: .value("Count", Int(stats.intelligence) ?? 0),
                innerRadius: .ratio(0.6),
                angularInset: 5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", "Intelligence"))
            
            SectorMark(
                angle: .value("Count", Int(stats.power) ?? 0),
                innerRadius: .ratio(0.6),
                angularInset: 5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", "Power"))
            
            SectorMark(
                angle: .value("Count", Int(stats.speed) ?? 0),
                innerRadius: .ratio(0.6),
                angularInset: 5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", "Speed"))
            
            SectorMark(
                angle: .value("Count", Int(stats.strength) ?? 0),
                innerRadius: .ratio(0.6),
                angularInset: 5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", "Strength"))
            
        }.padding(30)
    }
}

#Preview {
    SuperHeroDetail(id: "1")
}
