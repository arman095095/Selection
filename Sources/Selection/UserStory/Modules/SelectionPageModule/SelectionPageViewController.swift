//
//  SelectionModuleViewController.swift
//  
//
//  Created by Арман Чархчян on 14.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SelectionPageViewInput: AnyObject {
    func setupInitialState()
    func reloadData()
}

final class SelectionPageViewController: UIViewController {
    var output: SelectionPageViewOutput?
    private var tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

private extension SelectionPageViewController {
    
    func setupViews() {
        setupTableView()
        setupSearchBar()
    }

    func setupTableView() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 40
    }

    func setupSearchBar() {
        navigationItem.title = output?.title
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back",
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: #selector(backTapped(sender:)))
        navigationItem.leftBarButtonItem = newBackButton
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        output?.backButtonAction()
        _ = navigationController?.popViewController(animated: true)
    }
}

extension SelectionPageViewController: SelectionPageViewInput {
    func setupInitialState() {
        setupViews()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SelectionPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = output?.itemName(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.itemSelected(at: indexPath)
        searchController.searchBar.text = nil
    }
}

extension SelectionPageViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        output?.filter(text: text)
    }
}
