//
//  BaseTableViewControllerView.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/// Base class for TableViewController view
open class BaseTableViewControllerView: BaseView {
  
  // MARK: - Outlets
  
  @IBOutlet public weak var tableView: UITableView!
  
  // MARK: - Properties
  
  open var usedCells: [UITableViewCell.Type] {
    fatalError("Should be implemented by subclass")
  }
}
