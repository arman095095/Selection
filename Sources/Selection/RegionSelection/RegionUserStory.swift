//
//  File.swift
//
//
//  Created by Арман Чархчян on 14.04.2022.
//

import Foundation
import Module

public protocol RegionSelectionModuleProtocol {
    func countryAndCityModule() -> SelectionModule
}

public final class RegionUserStory {
    private let parentUserStory: SelectionModuleProtocol

    public init() {
        self.parentUserStory = SelectionUserStory()
    }
}

extension RegionUserStory: RegionSelectionModuleProtocol {
    public func countryAndCityModule() -> SelectionModule {
        let regionFactory = RegionFactory(flow: .countryAndCity)
        return parentUserStory.rootModule(model: regionFactory)
    }
}
