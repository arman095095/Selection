//
//  File.swift
//  
//
//  Created by Арман Чархчян on 14.04.2022.
//

import Foundation
import UIKit
import SelectionRouteMap

final class RootModuleOutputWrapper {
    weak var output: SelectionModuleOutput?
    private var model: SelectionModelProtocol
    private let routeMap: RouteMapPrivate
    private var selectedItems: [String]
    
    init(model: SelectionModelProtocol,
         routeMap: RouteMapPrivate) {
        self.model = model
        self.routeMap = routeMap
        self.selectedItems = []
    }
    
    func view() -> UIViewController {
        let model = model.startPageModel
        let module = routeMap.selectionPageModule(model: model)
        module.output = self
        return module.view
    }
}

extension RootModuleOutputWrapper: SelectionModuleInput { }

extension RootModuleOutputWrapper: SelectionPageModuleOutput {

    func selectionCanceled() {
        guard !selectedItems.isEmpty else { return }
        selectedItems.removeLast()
    }
    
    func itemSelected(item: String) -> SelectionPageModelProtocol? {
        selectedItems.append(item)
        guard let page =  model.nextPage(with: item,
                                         selectedCount: selectedItems.count) else {
            output?.selectionCompleted(items: selectedItems)
            return nil
        }
        return page
    }
}
