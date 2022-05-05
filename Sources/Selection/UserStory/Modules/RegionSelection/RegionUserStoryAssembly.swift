//
//  File.swift
//  
//
//  Created by Арман Чархчян on 05.05.2022.
//

import Foundation
import Swinject
import SelectionRouteMap

public final class RegionSelectionUserStoryAssembly: Assembly {
    public init() { }
    public func assemble(container: Container) {
        container.register(RegionSelectionRouteMap.self) { r in
            RegionUserStory(container: container)
        }
    }
}
