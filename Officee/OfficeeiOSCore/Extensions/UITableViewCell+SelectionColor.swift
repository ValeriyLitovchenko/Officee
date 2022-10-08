//
//  UITableViewCell+SelectionColor.swift
//
//  Created by Valeriy L on 19.09.2022.
//

import UIKit

public extension UITableViewCell {
  /// Sets cell selection background color by configuring selectedBackgroundView
  func setSelectionBackgroundColor(_ color: UIColor?) {
    guard let color = color else {
      selectedBackgroundView = nil
      return
    }

    let selectedBackgroundView = UIView(frame: bounds)
    selectedBackgroundView.backgroundColor = color
    self.selectedBackgroundView = selectedBackgroundView
  }
}
