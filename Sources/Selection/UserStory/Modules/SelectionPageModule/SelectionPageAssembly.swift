//
//  SelectionModuleAssembly.swift
//  
//
//  Created by Арман Чархчян on 14.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Module

typealias SelectionPageModule = Module<SelectionPageModuleInput, SelectionPageModuleOutput>

enum SelectionPageAssembly {
    static func makeModule(model: SelectionPageModelProtocol,
                           routeMap: RouteMapPrivate) -> SelectionPageModule {
        let view = SelectionPageViewController()
        let router = SelectionPageRouter(routeMap: routeMap)
        let presenter = SelectionPagePresenter(router: router,
                                               model: model)
        view.output = presenter
        presenter.view = view
        router.transitionHandler = view
        return SelectionPageModule(input: presenter, view: view) {
            presenter.output = $0
        }
    }
}
