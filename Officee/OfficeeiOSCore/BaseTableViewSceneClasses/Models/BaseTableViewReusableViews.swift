//
//  BaseTableViewReusableViews.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/// Base type for table cell model objects
public class BaseTableCellModel: CellModel, Hashable {
  
  // MARK: - Properties
  
  public let cellIdentifier: TableCellIdentifier
  public let cellHeight: CGFloat
  
  public var type: UITableViewCell.Type {
    fatalError("Should be implemented by subclass")
  }
  
  // MARK: - Constructor
  
  public init(
    identifier: TableCellIdentifier = UUID().uuidString,
    height: CGFloat = UITableView.automaticDimension
  ) {
    cellIdentifier = identifier
    cellHeight = height
  }
  
  // MARK: - Destructor
  
  deinit {
    debugPrint("Did deinit \(String(describing: self.self))")
  }
  
  // MARK: - Functions
  
  open func hash(into hasher: inout Hasher) {
    hasher.combine(cellIdentifier)
  }
  
  public static func == (lhs: BaseTableCellModel, rhs: BaseTableCellModel) -> Bool {
    lhs.cellIdentifier == rhs.cellIdentifier
  }
}

public typealias TableCellIdentifier = String

/// Base type for table cells
public class BaseTableCell: UITableViewCell {
  
  // MARK: - Destructor
  
  deinit {
    debugPrint("Did deinit \(String(describing: type(of: self)))")
  }
  
  // MARK: - Functions
  
  open func configure(with _: BaseTableCellModel) {
    fatalError("Should be implemented by subclass")
  }
}
