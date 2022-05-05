//
//  File.swift
//
//
//  Created by Арман Чархчян on 14.04.2022.
//

import Foundation
import Module
import SelectionRouteMap
import Swinject

public final class RegionUserStory {
    private let parentUserStory: SelectionModuleProtocol

    public init(container: Container) {
        self.parentUserStory = SelectionUserStory(container: container)
    }
}

extension RegionUserStory: RegionSelectionRouteMap {
    public func countryAndCityModule() -> SelectionModule {
        let regionFactory = RegionFactory(flow: .countryAndCity)
        return parentUserStory.rootModule(model: regionFactory)
    }
}
