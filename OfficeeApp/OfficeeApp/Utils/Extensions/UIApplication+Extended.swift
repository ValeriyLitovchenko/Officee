//
//  UIApplication+Extended.swift
//  OfficeeApp
//
//  Created by Valeriy L on 16.10.2022.
//

import UIKit

extension UIApplication {
  var currentWindow: UIWindow? {
    (connectedScenes
      .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene)?
      .windows
      .first(where: \.isKeyWindow)
  }
}
