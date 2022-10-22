//
//  ToastViewPresenter.swift
//  OfficeeApp
//
//  Created by Valeriy L on 16.10.2022.
//

import UIKit

protocol ToastViewPresenter {
  func showAutohidingToastView(with message: String)
}

extension ToastViewPresenter {
  func showAutohidingToastView(with message: String) {
    guard let window = UIApplication.shared.currentWindow else { return }
    
    let toastView = ToastView()
    toastView.set(configs: .forApplication)
    toastView.showAsynchronously(
      with: message,
      in: window,
      autoHideDelay: 3.2)
  }
}

// swiftlint:disable force_unwrapping
extension ToastView.VisualConfigs {
  static var forApplication: Self {
    .init(
      backgroundColor: DefinedColors.ToastView.background.color!,
      foregroundColor: DefinedColors.ToastView.foreground.color!,
      borderColor: .white,
      borderWidth: .zero,
      cornerRadius: 8.0)
  }
}
