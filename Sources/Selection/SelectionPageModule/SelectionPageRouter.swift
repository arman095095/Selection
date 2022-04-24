//
//  SelectionModuleRouter.swift
//  
//
//  Created by Арман Чархчян on 14.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Module

protocol SelectionPageRouterInput: AnyObject {
    func openNextPage(model: SelectionPageModelProtocol)
}

final class SelectionPageRouter {
    weak var transitionHandler: UIViewController?
    private let routeMap: RouteMapPrivate
    
    init(routeMap: RouteMapPrivate) {
        self.routeMap = routeMap
    }
}

extension SelectionPageRouter: SelectionPageRouterInput {
    func openNextPage(model: SelectionPageModelProtocol) {
        let module = routeMap.selectionPageModule(model: model)
        self.push(module)
    }
}

private extension SelectionPageRouter {
    func push(_ module: ModuleProtocol) {
        let pushTransition = PushTransition()
        pushTransition.source = transitionHandler
        pushTransition.destination = module.view
        pushTransition.perform(nil)
    }
}
