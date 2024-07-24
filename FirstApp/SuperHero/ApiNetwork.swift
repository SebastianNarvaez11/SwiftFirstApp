//
//  ApiNetwork.swift
//  FirstApp
//
//  Created by Sebastian on 20/07/24.
//

import Foundation


class ApiNetwork {
    
    struct Wrapper:Codable{
        let response:String
        let results:[SuperHero]
    }
    
    struct SuperHero:Codable, Identifiable{
        let id, name:String
        let image: SuperheroImage
    }
    
    struct SuperheroImage:Codable{
        let url:String
    }
    
    struct SuperheroDetail:Codable{
        let id, name:String
        let image: SuperheroImage
        let powerstats:PowerStats
        let biography:Biography
    }
    
    struct PowerStats:Codable{
        let intelligence, strength, speed, durability, power, combat: String
    }
    
    struct Biography:Codable{
        let fullName, publisher, alignment: String
        let aliases: [String]
        
        enum CodingKeys:String, CodingKey {
            case fullName = "full-name"
            case aliases, publisher, alignment
        }
    }
    
    
    func getSuperheroByName (name:String) async throws -> Wrapper {
        let url = URL(string: "https://superheroapi.com/api/25c1a1dc1616f95283fd7e73a71b86d9/search/\(name)")!
        
        let (data, _) = try await URLSession.shared.data(from:url)
        
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        
        return wrapper
    }
    
    func getSuperheroById (id:String) async throws -> SuperheroDetail {
        let url = URL(string: "https://superheroapi.com/api/25c1a1dc1616f95283fd7e73a71b86d9/\(id)")!

        let (data, _) = try await URLSession.shared.data(from:url)
        
        return try JSONDecoder().decode(SuperheroDetail.self, from: data)
    }
}
