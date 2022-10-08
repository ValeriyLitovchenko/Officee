//
//  UIViewExtensions.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

public extension UIView {
  
  /// Adds subview with pinning edges to self as superview
  func addPinnedSubview(
    _ subview: UIView,
    side: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]) {
      
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    subview.pinEdges(to: self, side: side)
  }
  
  /// Pins subview edges to self as superview
  func pinEdges(
    to other: UIView,
    side: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]) {
      
    let attributes: [NSLayoutConstraint.Attribute] = side
    NSLayoutConstraint.activate(attributes.map {
      NSLayoutConstraint(
        item: other,
        attribute: $0,
        relatedBy: .equal,
        toItem: self,
        attribute: $0,
        multiplier: 1,
        constant: .zero)
    })
  }
}
