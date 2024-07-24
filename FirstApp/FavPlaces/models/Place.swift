//
//  Place.swift
//  FirstApp
//
//  Created by Sebastian on 23/07/24.
//

import Foundation
import MapKit

struct Place:Identifiable, Codable{
    var id = UUID()
    var name : String
    var location : CLLocationCoordinate2D
    var isFavorite : Bool
    
//    DECODE
//    esto se hace para guardar en UserDefaults que es un especie de async storage
//    se debe transformar al guardarlo y al recuperarlo se debe volver a convertir
//    en estos pasos lo estamos recuperando para decodifircarlo
    
    enum CodingKeys:CodingKey{
        case id, name, location, isFavorite, latitude, longitude
    }
    
    init(id: UUID = UUID(), name: String, location: CLLocationCoordinate2D, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.location = location
        self.isFavorite = isFavorite
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        name = try container.decode(String.self, forKey: .name)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
//    ENCODE
//    aqui lo estamos preparando para guardarlo como texto plano
 
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location.latitude, forKey: .latitude)
        try container.encode(location.longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(id, forKey: .id)
    }
}
