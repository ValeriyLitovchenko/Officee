//
//  PersonDetailsControllerView.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class PersonDetailsControllerView: BaseTableViewControllerView {
  override var usedCells: [UITableViewCell.Type] {
    [
      PersonDetailsAvatarCell.self,
      PersonDetailsTitleCell.self,
      PersonDetailsSubtitleCell.self,
      PersonDetailsAttributeCell.self,
      SpacingCell.self
    ]
  }
  
  private(set) lazy var activityIndicator = addActivityIndicatorView()
}
