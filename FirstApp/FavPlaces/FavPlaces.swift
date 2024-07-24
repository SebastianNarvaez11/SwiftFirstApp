//
//  FavPlaces.swift
//  FirstApp
//
//  Created by Sebastian on 21/07/24.
//

import SwiftUI
import MapKit

struct FavPlaces: View {
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.419969, longitude: -3.702561),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    )
    
    @State var places:[Place] = []
    @State var namePlace:String = ""
    @State var isFavorite:Bool = false
    @State var showDialog:CLLocationCoordinate2D? = nil
    @State var showSheet:Bool = false
    let height = stride(from: 0.3, through: 0.6, by: 0.1).map{ PresentationDetent.fraction($0) }
    
    var body: some View {
        ZStack{
            MapReader{ proxy in
                Map(position: $position){
                    ForEach(places) { place in
                        Annotation(place.name, coordinate: place.location){
                            Circle()
                                .stroke(place.isFavorite ? .blue : .black, lineWidth: 10)
                                .fill(.white)
                                .frame(width: 35, height: 35)
                        }
                    }
                }.onTapGesture { coords in
                    withAnimation(){
                        if let coordinates = proxy.convert(coords, from: .local){
                            showDialog = coordinates
                        }
                    }
                }.overlay(){
                    VStack{
                        Button("Show List"){
                            showSheet = true
                        }
                        .padding()
                        .background(.white)
                        Spacer()
                    }
                }
                
            }
            
            
            if showDialog != nil {
                let view = VStack{
                    Text("Agregar localizacion")
                    TextField("Nombre",text: $namePlace)
                    Toggle("¿Esa favorito ?", isOn: $isFavorite)
                    Button("Guardar"){
                        savePlace(name: namePlace, isFavorite: isFavorite, coord: showDialog!)
                        clearForm()
                    }
                }
                
                CustomDialog(closeDialog: {
                    showDialog = nil
                }, onDismissOutside: true, content: view)
            }
            
        }.sheet(isPresented: $showSheet){
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(places) { place in
                        VStack{
                            Text(place.name).font(.title).bold()
                        }
                        .frame(width: 150, height: 100)
                        .cornerRadius(20)
                        .overlay(){
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(place.isFavorite ? .blue : .black, lineWidth: 3)
                        }
                        .shadow(radius: 5)
                        .padding(.horizontal, 8)
                        .onTapGesture {
                            moveCameraToPlace(coord: place.location)
                            showSheet = false
                        }
                    }
                }
            }.presentationDetents(Set(height))
        }.onAppear(){
            loadPlaces()
        }
    }
    
    func savePlace (name:String, isFavorite:Bool, coord:CLLocationCoordinate2D) {
        let place:Place = Place(name: name, location: coord, isFavorite: isFavorite)
        places.append(place)
        savePlaces()
    }
    
    func clearForm () {
        namePlace = ""
        showDialog = nil
        isFavorite = false
    }
    
    func moveCameraToPlace (coord: CLLocationCoordinate2D) {
        withAnimation(){
            position = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: coord,
                    span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            )
        }
    }
}

#Preview {
    FavPlaces()
}


extension FavPlaces {
    
    func savePlaces() {
        if let encodePlaces = try? JSONEncoder().encode(places){
            UserDefaults.standard.set(encodePlaces, forKey: "places")
        }
    }
    
    
    func loadPlaces() {
        if let savedPlaces = UserDefaults.standard.data(forKey: "places"),
           let decodedPlaces = try? JSONDecoder().decode([Place].self, from: savedPlaces){
            places = decodedPlaces
        }
    }
}
