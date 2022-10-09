//
//  ActivityIndicatorView.swift
//  ActivityIndicatorView
//
//  Created by Valeriy L on 24.08.2022.
//

import UIKit

/// Customizable ActivityIndicatorView
final class ActivityIndicatorView: UIView {
  
  struct Style {
    
    // MARK: - Properties
    
    let bgColor: UIColor
    let indicatorStyle: UIActivityIndicatorView.Style
    let indicatorColor: UIColor
    
    // MARK: - Constructor
    
    init(
      bgColor: UIColor = .white,
      indicatorColor: UIColor = .lightGray,
      indicatorStyle: UIActivityIndicatorView.Style? = nil
    ) {
      self.bgColor = bgColor
      self.indicatorColor = indicatorColor
      
      if #available(iOS 13.0, *) {
        self.indicatorStyle = indicatorStyle ?? .large
      } else {
        self.indicatorStyle = indicatorStyle ?? .gray
      }
    }
    
    static var `default`: Self {
      ActivityIndicatorView.Style()
    }
  }
  
  // MARK: - Properties
  
  var isAnimating = false {
    didSet {
      isAnimating ? startAnimating() : stopAnimating()
    }
  }
  
  private let indicator: UIActivityIndicatorView
  
  var animationDuration: TimeInterval = 0.2
  
  // MARK: - Constructor
  
  init(style: ActivityIndicatorView.Style = .default) {
    
    indicator = UIActivityIndicatorView(style: style.indicatorStyle)
    super.init(frame: .zero)
    
    indicator.hidesWhenStopped = true
    indicator.color = style.indicatorColor
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = style.bgColor
    addSubview(indicator)
    
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    indicator.hidesWhenStopped = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("Is not implemented")
  }
  
  // MARK: - Methods
  
  func setIsAnimating(_ isAnimating: Bool) {
    self.isAnimating = isAnimating
  }
  
  /// Show activity indicator and start animation. Performs asynchronously in `MainThread`
  func startAnimating() {
    DispatchQueue.main.async {
      self.isHidden = false
      UIView.animate(
        withDuration: self.animationDuration) {
        self.alpha = 1
        self.indicator.startAnimating()
      }
    }
  }
  
  /// Hide activity indicator and stop animation. Performs asynchronously in `MainThread`
  func stopAnimating() {
    DispatchQueue.main.async {
      UIView.animate(
        withDuration: self.animationDuration,
        animations: {
          self.alpha = .zero
        },
        completion: { [weak self] _ in
          self?.indicator.stopAnimating()
          self?.isHidden = true
        }
      )
    }
  }
}
