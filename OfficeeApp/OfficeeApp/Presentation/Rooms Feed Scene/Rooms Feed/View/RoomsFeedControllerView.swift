//
//  RoomsFeedControllerView.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

final class RoomsFeedControllerView: SearchFeedControllerView {
  override var usedCells: [UITableViewCell.Type] {
    [
      SearchFeedNoResultsCell.self,
      SpacingCell.self,
      RoomCell.self
    ]
  }
}
