//
//  File.swift
//  
//
//  Created by Арман Чархчян on 15.04.2022.
//

import Foundation

struct RegionFactory: SelectionModelProtocol {
    
    enum FlowType {
        case countryAndCity
        
        var pagesCount: Int {
            switch self {
            case .countryAndCity:
                return 2
            }
        }
    }

    let startPageModel: SelectionPageModelProtocol
    private let pagesCount: Int
    
    init(flow: FlowType) {
        switch flow {
        case .countryAndCity:
            self.startPageModel = CountryFactory()
            self.pagesCount = flow.pagesCount
        }
    }
    
    func nextPage(with item: String, selectedCount: Int) -> SelectionPageModelProtocol? {
        guard selectedCount != pagesCount else { return nil }
        guard let country = Regions.Country(name: item) else { return nil }
        let cities = Regions().cities(at: country)
        return CityFactory(cities: cities)
    }
}

struct CountryFactory: SelectionPageModelProtocol {

    var title: String {
        "Выберите страну"
    }
    
    var list: [String] {
        Regions.Country.allCases.map { $0.name }
    }
}

struct CityFactory: SelectionPageModelProtocol {
    let list: [String]
    
    var title: String {
        "Выберите город"
    }
    
    init(cities: [Regions.City]) {
        self.list = cities.map { $0.name }
    }
}
