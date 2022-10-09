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
  override func configure(with _: BaseTableCellModel) {}
}
