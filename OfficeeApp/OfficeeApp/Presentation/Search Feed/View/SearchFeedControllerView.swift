//
//  SearchFeedControllerView.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

class SearchFeedControllerView: BaseTableViewControllerView {
  override var usedCells: [UITableViewCell.Type] {
    [
      SearchFeedNoResultsCell.self
    ]
  }
  
  private(set) lazy var activityIndicator = addActivityIndicatorView()
}
