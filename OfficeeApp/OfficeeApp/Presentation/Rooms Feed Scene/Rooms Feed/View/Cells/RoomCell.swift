//
//  RoomCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class RoomCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    RoomCell.self
  }
  
  let name: String
  let isOccupied: Bool
  let maxOccupancy: String
  
  // MARK: - Constructor
  
  init(
    identifier: TableCellIdentifier,
    name: String,
    isOccupied: Bool,
    maxOccupancy: String
  ) {
    self.name = name
    self.isOccupied = isOccupied
    self.maxOccupancy = maxOccupancy
    super.init(identifier: identifier)
  }
}

final class RoomCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var maxOccupancyLabel: UILabel!
  @IBOutlet private weak var occupiedLabel: UILabel!
  
  // MARK: - Functions
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? RoomCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    nameLabel.text = model.name
    maxOccupancyLabel.text = model.maxOccupancy
    occupiedLabel.text = NSLocalizedString("Occupied", comment: "")
    occupiedLabel.isHidden = !model.isOccupied
  }
}
