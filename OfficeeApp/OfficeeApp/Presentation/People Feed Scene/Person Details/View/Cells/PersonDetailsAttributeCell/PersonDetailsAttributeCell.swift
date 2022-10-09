//
//  PersonDetailsAttributeCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class PersonDetailsAttributeCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PersonDetailsAttributeCell.self
  }
  
  let name: String
  let value: String
  
  // MARK: - Constructor
  
  init(name: String, value: String) {
    self.name = name
    self.value = value
  }
}

final class PersonDetailsAttributeCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var attributeNameLabel: UILabel!
  @IBOutlet private weak var attributeValueLabel: UILabel!
  
  // MARK: - Functions
  
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PersonDetailsAttributeCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    attributeNameLabel.text = model.name
    attributeValueLabel.text = model.value
  }
}
