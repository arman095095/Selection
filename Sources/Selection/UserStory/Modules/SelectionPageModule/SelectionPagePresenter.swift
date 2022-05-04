//
//  SelectionModulePresenter.swift
//  
//
//  Created by Арман Чархчян on 14.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SelectionRouteMap

protocol SelectionPageViewOutput: AnyObject {
    var numberOfRows: Int { get }
    var title: String { get }
    func viewDidLoad()
    func itemSelected(at indexPath: IndexPath)
    func itemName(at indexPath: IndexPath) -> String
    func filter(text: String)
    func backButtonAction()
}

struct SelectionPageModel: SelectionPageModelProtocol {
    var title: String
    var list: [String]
}

final class SelectionPagePresenter {
    
    weak var view: SelectionPageViewInput?
    weak var output: SelectionPageModuleOutput?
    private let router: SelectionPageRouterInput
    private let model: SelectionPageModelProtocol
    private var filteredItems: [String]
    
    init(router: SelectionPageRouterInput,
         model: SelectionPageModelProtocol) {
        self.router = router
        self.model = model
        self.filteredItems = model.list
    }
}

extension SelectionPagePresenter: SelectionPageViewOutput {
    
    func viewDidLoad() {
        view?.setupInitialState()
    }
    
    var title: String {
        return model.title
    }
    
    var numberOfRows: Int {
        filteredItems.count
    }
    
    func backButtonAction() {
        output?.selectionCanceled()
    }
    
    func itemName(at indexPath: IndexPath) -> String {
        filteredItems[indexPath.row]
    }
    
    func filter(text: String) {
        filteredItems = !text.isEmpty ? model.list.filter { $0.contains(text) } : model.list
        view?.reloadData()
    }
    
    func itemSelected(at indexPath: IndexPath) {
        let item = filteredItems[indexPath.row]
        guard let model = output?.itemSelected(item: item) else { return }
        router.openNextPage(model: model)
    }
}

extension SelectionPagePresenter: SelectionPageModuleInput {
    
}
