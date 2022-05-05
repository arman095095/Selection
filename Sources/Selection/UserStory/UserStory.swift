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

protocol RouteMapPrivate {
    func selectionPageModule(model: SelectionPageModelProtocol) -> SelectionPageModule
}

public final class SelectionUserStory: SelectionModuleProtocol {

    private let container: Container
    private var outputWrapper: RootModuleOutputWrapper?

    public init(container: Container) {
        self.container = container
    }
    public func rootModule(model: SelectionModelProtocol) -> SelectionModule {
        let module = RootModuleOutputWrapperAssembly.assembly(model: model,
                                                              routeMap: self)
        outputWrapper = module.input as? RootModuleOutputWrapper
        return module
    }
}

extension SelectionUserStory: RouteMapPrivate {
    func selectionPageModule(model: SelectionPageModelProtocol) -> SelectionPageModule {
        let module = SelectionPageAssembly.makeModule(model: model, routeMap: self)
        module.output = outputWrapper
        return module
    }
}
