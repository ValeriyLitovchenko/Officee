//
//  PersonDetailsTitleCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class PersonDetailsTitleCellModel: BaseTableCellModel {
  override var type: UITableViewCell.Type {
    PersonDetailsTitleCell.self
  }
  
  let title: String
  
  init(title: String) {
    self.title = title
    super.init(identifier: title)
  }
}

final class PersonDetailsTitleCell: BaseTableCell {
  @IBOutlet private weak var titleLabel: UILabel!
  
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PersonDetailsTitleCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    titleLabel.text = model.title
  }
}
