//
//  SearchFeedControllerView.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class SearchFeedControllerView: BaseTableViewControllerView {
  override var usedCells: [UITableViewCell.Type] {
    []
  }
  
  private(set) lazy var activityIndicator = addActivityIndicatorView()
}
