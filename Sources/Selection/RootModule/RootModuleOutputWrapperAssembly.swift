//
//  File.swift
//  
//
//  Created by Арман Чархчян on 15.04.2022.
//

import Foundation
import Module

typealias SelectionModule = Module<SelectionModuleInput, SelectionModuleOutput>

enum RootModuleOutputWrapperAssembly {
    static func assembly(model: SelectionModelProtocol,
                         routeMap: RouteMapPrivate) -> SelectionModule {
        let wrapper = RootModuleOutputWrapper(model: model, routeMap: routeMap)
        let module = SelectionModule(input: wrapper, view: wrapper.view()) {
            wrapper.output = $0
        }
        return module
    }
}
