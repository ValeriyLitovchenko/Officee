//
//  ToastView.swift
//  OfficeeApp
//
//  Created by Valeriy L on 16.10.2022.
//

import UIKit

open class ToastView: UIView {
  struct VisualConfigs {
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let borderColor: UIColor
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
  }
  
  private enum ConstraintState {
    static let active = UILayoutPriority(998.0)
    static let inactive = UILayoutPriority(5.0)
  }
  
  @IBOutlet private(set) weak var textLabel: UILabel!
  @IBOutlet private(set) weak var containerView: UIView!
  
  private weak var topConstraint: NSLayoutConstraint?
  private weak var bottomConstraint: NSLayoutConstraint?
  
  private var configs: ToastView.VisualConfigs = .default {
    didSet {
      textLabel.textColor = configs.foregroundColor
      containerView.backgroundColor = configs.backgroundColor
      containerView.layer.borderWidth = configs.borderWidth
      containerView.layer.borderColor = configs.borderColor.cgColor
      containerView.layer.cornerRadius = configs.cornerRadius
    }
  }
  
  // MARK: - Constructor
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  public required init?(coder: NSCoder) {
    // swiftlint:disable fatal_error_message
    fatalError()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  deinit {
    debugPrint("did deinit ToastView")
  }
  
  // MARK: - Fucntions
  
  func showAsynchronously(
    with message: String,
    in externalContainer: UIView,
    autoHideDelay: TimeInterval? = nil
  ) {
    DispatchQueue.main.async {
      self.show(
        with: message,
        in: externalContainer,
        autoHideDelay: autoHideDelay)
    }
  }
  
  func hideAsynchronously(with delay: TimeInterval? = nil) {
    debugPrint("hideAsynchronously")
    let delay = delay?.dispatchInterval ?? .seconds(.zero)
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
      self?.hide()
    }
  }
  
  func set(configs: ToastView.VisualConfigs) {
    self.configs = configs
  }
  
  // MARK: - Private Functions
  
  @objc
  private func onTapHideAction() {
    hide()
  }
  
  private func show(
    with message: String,
    in externalContainer: UIView,
    autoHideDelay: TimeInterval?
  ) {
    debugPrint("start showing")
    textLabel.text = message
    
    constraint(to: externalContainer)
    
    UIView.animate(
      withDuration: 0.17,
      animations: { [topConstraint, bottomConstraint, superview] in
        topConstraint?.priority = ConstraintState.inactive
        bottomConstraint?.priority = ConstraintState.active
        superview?.layoutIfNeeded()
      },
      completion: { [weak self] _ in
        debugPrint("finish showing")
        debugPrint(self?.frame ?? .zero)
        debugPrint(self?.textLabel?.frame ?? .zero)
        
        guard let autoHideDelay = autoHideDelay,
                let self = self else { return }
        self.hideAsynchronously(with: autoHideDelay)
      })
  }
  
  private func hide() {
    debugPrint("Start hiding")
    UIView.animate(
      withDuration: 0.18,
      animations: { [topConstraint, bottomConstraint, superview] in
        topConstraint?.priority = ConstraintState.active
        bottomConstraint?.priority = ConstraintState.inactive
        superview?.layoutIfNeeded()
      },
      completion: { [weak self] _ in
        debugPrint("Finish hiding")
        self?.removeFromSuperview()
      })
  }
  
  private func constraint(to externalContainer: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    externalContainer.addSubview(self)
    externalContainer.bringSubviewToFront(self)
    
    let spacing = CGFloat(20.0)
    let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: 50.0)
    
    let topConstraint = topAnchor.constraint(equalTo: externalContainer.bottomAnchor, constant: spacing)
    topConstraint.priority = ConstraintState.active
    self.topConstraint = topConstraint
    let bottomConstraint = bottomAnchor.constraint(equalTo: externalContainer.bottomAnchor, constant: -spacing)
    bottomConstraint.priority = ConstraintState.inactive
    self.bottomConstraint = bottomConstraint
    
    let centerX = centerXAnchor.constraint(equalTo: externalContainer.centerXAnchor, constant: .zero)
    let width = widthAnchor.constraint(equalTo: externalContainer.widthAnchor, constant: -(spacing * 2))
    width.priority = UILayoutPriority(998.0)
    let widthConstraint = widthAnchor.constraint(lessThanOrEqualToConstant: 380.0)
    
    NSLayoutConstraint.activate([
      width,
      widthConstraint,
      centerX,
      topConstraint,
      bottomConstraint,
      heightConstraint
    ])
    
    externalContainer.setNeedsLayout()
    externalContainer.layoutIfNeeded()
  }
  
  private func setup() {
    debugPrint("start setup")
    let textLabel = UILabel(frame: bounds)
    textLabel.numberOfLines = .zero
    textLabel.textAlignment = .center
    textLabel.textColor = .black
    textLabel.setContentHuggingPriority(.init(253.0), for: .vertical)
    textLabel.setContentCompressionResistancePriority(.init(993.0), for: .horizontal)
    textLabel.setContentCompressionResistancePriority(.init(998.0), for: .vertical)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.textLabel = textLabel
    
    let containerView = UIView(frame: bounds)
    containerView.layer.borderWidth = 1.0
    containerView.layer.borderColor = UIColor.black.cgColor
    containerView.layer.cornerRadius = 8.0
    containerView.backgroundColor = .white
    containerView.translatesAutoresizingMaskIntoConstraints = false
    self.containerView = containerView
    
    let spacing = CGFloat(10.0)
    containerView.addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: spacing),
      textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -spacing),
      textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -spacing),
      textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: spacing)
    ])
    
    addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero),
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: .zero)
    ])
    debugPrint("finish setup")
    
    textLabel.isUserInteractionEnabled = false
    containerView.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapHideAction))
    containerView.addGestureRecognizer(tapGesture)
    
    configs = .default
  }
}

extension ToastView.VisualConfigs {
  static var `default`: Self {
    .init(
      backgroundColor: .white,
      foregroundColor: .black,
      borderColor: .black,
      borderWidth: 1.0,
      cornerRadius: 8.0)
  }
}
