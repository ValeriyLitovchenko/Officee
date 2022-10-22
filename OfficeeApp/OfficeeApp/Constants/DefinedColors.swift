//
//  DefinedColors.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit.UIColor

enum DefinedColors {
  static let guardsmanRed = ColorResource(name: "GuardsmanRed")
  static let avatarBorder = ColorResource(name: "AvatarBorder")
  static let flushMahogany = ColorResource(name: "FlushMahogany")
  static let activityIndicator = ColorResource(name: "ActivityIndicator")
  enum ToastView {
    static let background = ColorResource(name: "ToastViewBackground")
    static let foreground = ColorResource(name: "ToastViewForeground")
  }
}

struct ColorResource {
  let name: String
  
  var color: UIColor? {
    let color = UIColor(named: name)
    assert(color != nil, "Asset Color with name \(name) does not exist")
    return color
  }
}
