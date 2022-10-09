//
//  UIView+ActivityIndicatorView.swift
//  ActivityIndicatorView
//
//  Created by Valeriy L on 24.08.2022.
//

import UIKit

extension UIView {
  
  /// Creates view with activity indicator in the center
  /// Can be used on any view
  /// - Parameter bgColor: works as a shadow view, is clear by default
  /// - Returns: ActivityIndicatorView instance if needed
  @discardableResult
  func addActivityIndicatorView(bgColor: UIColor = .clear) -> ActivityIndicatorView {
    let indicator = ActivityIndicatorView(
      style: ActivityIndicatorView.Style(
        bgColor: bgColor,
        indicatorColor: DefinedColors.activityIndicator.color ?? .lightGray)
    )
    
    indicator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(indicator)
    
    indicator.pinEdges(to: self)
    
    return indicator
  }
}
