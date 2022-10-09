//
//  PersonDetailsAvatarCell.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import OfficeeiOSCore
import UIKit

final class PersonDetailsAvatarCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PersonDetailsAvatarCell.self
  }
  
  let avatar: String
  
  // MARK: - Constructor
  
  init(avatar: String) {
    self.avatar = avatar
    super.init(identifier: avatar, height: 170.0)
  }
}

final class PersonDetailsAvatarCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var avatarImageView: UIImageView!
  
  // MARK: - Functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    avatarImageView.accessibilityIgnoresInvertColors = true
    avatarImageView.layer.borderColor = DefinedColors.avatarBorder.color?.cgColor
  }
  
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PersonDetailsAvatarCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    avatarImageView.setImage(with: model.avatar)
  }
}
