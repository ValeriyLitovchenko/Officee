//
//  PersonCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class PersonCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PersonCell.self
  }
  
  let fullName: String
  let avatar: String
  let meetingDescription: String?
  
  // MARK: - Constructor
  
  init(
    identifier: TableCellIdentifier,
    fullName: String,
    avatar: String,
    meetingDescription: String?
  ) {
    self.fullName = fullName
    self.avatar = avatar
    self.meetingDescription = meetingDescription
    super.init(identifier: identifier)
  }
}

final class PersonCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var fullNameLabel: UILabel!
  @IBOutlet private weak var meetingDescriptionLabel: UILabel!
  @IBOutlet private weak var avatarView: UIImageView!
  
  // MARK: - Functions
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PersonCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    fullNameLabel.text = model.fullName
    meetingDescriptionLabel.text = model.meetingDescription
    avatarView.setImage(with: model.avatar)
  }
}
