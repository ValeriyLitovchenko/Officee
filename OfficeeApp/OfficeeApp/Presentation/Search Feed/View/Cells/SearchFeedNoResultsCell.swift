//
//  SearchFeedNoResultsCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class SearchFeedNoResultsCellModel: BaseTableCellModel {
  override var type: UITableViewCell.Type {
    SearchFeedNoResultsCell.self
  }
  
  let title: String
  
  init(title: String? = nil) {
    self.title = title ?? NSLocalizedString("No results were found.", comment: "")
  }
}

final class SearchFeedNoResultsCell: BaseTableCell {
  @IBOutlet private(set) weak var titleLabel: UILabel!
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? SearchFeedNoResultsCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    titleLabel.text = model.title
  }
}
