//
//  File.swift
//  
//
//  Created by Арман Чархчян on 14.04.2022.
//

import Foundation
import Module

public protocol SelectionModuleProtocol {
    func rootModule(model: SelectionModelProtocol) -> ModuleProtocol
}

protocol RouteMapPrivate {
    func selectionPageModule(model: SelectionPageModelProtocol) -> SelectionPageModule
}

public final class SelectionUserStory: SelectionModuleProtocol {
    private var outputWrapper: RootModuleOutputWrapper?
    public func rootModule(model: SelectionModelProtocol) -> ModuleProtocol {
        let module = RootModuleOutputWrapperAssembly.assembly(model: model,
                                                              routeMap: self)
        outputWrapper = module.input as? RootModuleOutputWrapper
        return module
    }
}

extension SelectionUserStory: RouteMapPrivate {
    func selectionPageModule(model: SelectionPageModelProtocol) -> SelectionPageModule {
        let module = SelectionPageAssembly.makeModule(model: model, routeMap: self)
        module._output = outputWrapper
        return module
    }
}