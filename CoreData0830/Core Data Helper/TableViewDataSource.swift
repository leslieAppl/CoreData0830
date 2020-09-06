//
//  TableViewDataSource.swift
//  CoreData0830
//
//  Created by leslie on 9/4/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit
import CoreData

protocol TableViewDataSourceDelegate: class {
    associatedtype Object: NSFetchRequestResult  //abstract type
    associatedtype Cell: UITableViewCell        //abstract type
    
    // Abstract & common Protocol method
    func configure(_ cell: Cell, for object: Object)
}

class TableViewDataSource<Delegate: TableViewDataSourceDelegate>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    typealias Object = Delegate.Object  //concrete type
    typealias Cell = Delegate.Cell      //concrete type
    
    required init(tableView: UITableView, cellIdentifier: String, fetchedResultsController: NSFetchedResultsController<Object>, delegate: Delegate) {
        
        //MARK: - Init
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        super.init()
        
        //MARK: - Configue
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
        
        tableView.dataSource = self
        tableView.reloadData()
    }

    
    // MARK: Private
    fileprivate let tableView: UITableView
    fileprivate let fetchedResultsController: NSFetchedResultsController<Object>
    fileprivate weak var delegate: Delegate!
    fileprivate let cellIdentifier: String
    
    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = fetchedResultsController.object(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell
        else {
            fatalError("Unexpected cell type at \(indexPath)")
        }
        
        ///Ask the delegate of the TableViewDataSource to configure a specific cell.
        ///This way, we can reuse the TableViewDataSource class for other table views in the app.
        delegate.configure(cell, for: object)
        
        return cell
    }
    
    // MARK: NSFetchedResultsControllerDelegate

}
