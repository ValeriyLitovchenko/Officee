//
//  PersonCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

final class PersonCellModel: BaseTableCellModel, ApplicableActionModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PersonCell.self
  }
  
  let fullName: String
  let avatar: String
  let job: String
  let meetingDescription: String?
  let onAction: VoidCallback
  
  // MARK: - Constructor
  
  init(
    identifier: TableCellIdentifier,
    fullName: String,
    avatar: String,
    job: String,
    meetingDescription: String?,
    onAction: @escaping VoidCallback
  ) {
    self.fullName = fullName
    self.avatar = avatar
    self.job = job
    self.meetingDescription = meetingDescription
    self.onAction = onAction
    super.init(identifier: identifier)
  }
}

final class PersonCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var fullNameLabel: UILabel!
  @IBOutlet private weak var jobLabel: UILabel!
  @IBOutlet private weak var meetingDescriptionLabel: UILabel!
  @IBOutlet private weak var avatarView: UIImageView!
  
  // MARK: - Functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    avatarView.accessibilityIgnoresInvertColors = true
    avatarView.layer.borderColor = DefinedColors.avatarBorder.color?.cgColor
  }
  
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PersonCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    fullNameLabel.text = model.fullName
    jobLabel.text = model.job
    meetingDescriptionLabel.text = model.meetingDescription
    avatarView.setImage(with: model.avatar)
    
    avatarView.layer.borderWidth = model.meetingDescription == nil ? 1.0 : 3.0
  }
}
