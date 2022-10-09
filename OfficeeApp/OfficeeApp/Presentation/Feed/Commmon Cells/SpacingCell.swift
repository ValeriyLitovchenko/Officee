//
//  SpacingCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class SpacingCellModel: BaseTableCellModel {
  override var type: UITableViewCell.Type {
    SpacingCell.self
  }
  
  init(height: Double) {
    super.init(height: CGFloat(height))
  }
}

final class SpacingCell: BaseTableCell {
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  override func configure(with _: BaseTableCellModel) {}
}
