//
//  NetworkManager.swift
//  diffibleData
//
//  Created by Arman Davidoff on 04.12.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation

final class Regions {
    
    let countries: [Country] = Country.allCases
    
    func cities(at country: Country) -> [City] {
        switch country {
        case .ru:
            let response = Bundle.main.decoder(model: [Bundle.ResponseModelCitiesOther].self,
                                               url: "\(country.rawValue).json")
            return response.map { City(name: $0.city) }
        default:
            let response = Bundle.main.decoder(model: Bundle.ResponseModelCities.self,
                                               url: "\(country.rawValue).json")
            return response.items.map { City(name: $0.name) }
        }
    }
}

//MARK: Models
extension Regions {
    
    enum Country: String, CaseIterable {
        case ru
        case uk
        case by
        case am
        case az
        case md
        case uzb
        case kgz
        case tjk
        case kz
        
        init?(name: String) {
            guard let country = Country.allCases.filter({ $0.name == name }).first else { return nil }
            self = country
        }
        
        var name: String {
            switch self {
            case .ru:
                return "Россия"
            case .uk:
                return "Украина"
            case .by:
                return "Беларусь"
            case .am:
                return "Армения"
            case .az:
                return "Азербайджан"
            case .md:
                return "Молдова"
            case .uzb:
                return "Узбекистан"
            case .kgz:
                return "Киргизия"
            case .tjk:
                return "Таджикистан"
            case .kz:
                return "Казахстан"
            }
        }
    }
    
    struct City {
        let name: String
        init(name: String) {
            self.name = name
        }
    }
}

extension Bundle {
    
    // MARK: - Welcome
    struct ResponseModelCities: Decodable {
        let items: [Cities]
    }

    // MARK: - Item
    struct Cities: Decodable {
        let name: String
    }
    
    struct ResponseModelCitiesOther: Decodable {
        let city: String
    }
    
    func decoder<T: Decodable>(model: T.Type, url: String) -> T {
        print(self.url(forResource: url, withExtension: nil))
        guard let url = self.url(forResource: url, withExtension: nil) else { fatalError("incorrect adress") }
        guard let data = try? Data.init(contentsOf: url) else { fatalError("error loading") }
        guard let load = try? JSONDecoder().decode(T.self, from: data) else { fatalError("error decoding") }
        return load
    }
}
