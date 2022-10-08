//
//  UITableViewCell+Identifier.swift
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

public extension UITableViewCell {
  /// Returns identifier for cell type
  static var identifier: String {
    String(describing: self)
  }
}
