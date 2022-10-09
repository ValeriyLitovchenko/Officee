//
//  PeopleFeedControllerView.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

final class PeopleFeedControllerView: SearchFeedControllerView {
  override var usedCells: [UITableViewCell.Type] {
    [
      SearchFeedNoResultsCell.self,
      PersonCell.self,
      SpacingCell.self
    ]
  }
}
