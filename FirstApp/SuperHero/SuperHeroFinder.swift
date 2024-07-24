//
//  SuperHeroFinder.swift
//  FirstApp
//
//  Created by Sebastian on 20/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SuperHeroFinder: View {
    @State var searchText:String = ""
    @State var wrapper: ApiNetwork.Wrapper? = nil
    @State var isLoading:Bool = false
    
    var body: some View {
        VStack{
            TextField("", text: $searchText, prompt: Text("Ej: superman..."))
                .autocorrectionDisabled()
                .padding(10)
                .border(Color.purple)
                .padding(10)
                .onSubmit {
                    isLoading = true
                    print(searchText)
                    Task{
                        do{
                            let response = try await ApiNetwork().getSuperheroByName(name: searchText)
                            wrapper = response
                        }catch{
                            print("Error")
                        }
                        isLoading = false
                    }
                }
            
            isLoading ? ProgressView().tint(.white) : nil
            
            NavigationStack{
                List(wrapper?.results ?? []){ superhero in
                    ZStack{
                        SuperHeroItem(superhero: superhero)
                        NavigationLink(destination:SuperHeroDetail(id: superhero.id)){
                            EmptyView()
                        }.opacity(0)
                    }.listRowBackground(Color.backgroundApp)
                }.listStyle(.plain)
            }
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundApp)
    }
}


struct SuperHeroItem:View {
    var superhero:ApiNetwork.SuperHero
    
    var body: some View {
        ZStack{
            WebImage(url: URL(string: superhero.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            VStack{
                Spacer()
                Text(superhero.name)
                    .font(.title)
                    . foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.5))
            }
        }
        .frame(height: 200)
        .cornerRadius(20)
    }
}

#Preview {
    SuperHeroFinder()
}
