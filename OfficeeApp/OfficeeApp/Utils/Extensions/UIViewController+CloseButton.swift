//
//  UIViewController+CloseButton.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

extension UIViewController {
  enum CloseButtonItemPosition {
    case left
    case right
  }
  
  func addCloseButtonItem(
    _ position: UIViewController.CloseButtonItemPosition = .left
  ) {
    let closeItem = UIBarButtonItem(
      barButtonSystemItem: .close,
      target: self,
      action: #selector(closeButtonItemAction))
    switch position {
    case .left:
      navigationItem.leftBarButtonItem = closeItem
    case .right:
      navigationItem.rightBarButtonItem = closeItem
    }
  }
  
  @objc
  private func closeButtonItemAction() {
    dismiss(animated: true)
  }
}
