//
//  TableSceneModels.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import Foundation

/// A generic object which contains all required info to setup UI for one table view section
public class SectionModel<C: CellModel> {
  
  // MARK: - Properties
  
  public let identifier: SectionIdentifier
  public let items: [C]
  
  // MARK: - Constructor
  
  public init(identifier: SectionIdentifier, items: [C]) {
    self.identifier = identifier
    self.items = items
  }
}

public typealias SectionIdentifier = String

/**
 In general each cell has it's own cell object.
 All cells must inherit from base abstract classes.
 */
public protocol CellModel {
  associatedtype ReusableCellType
  
  var type: ReusableCellType { get }
}
