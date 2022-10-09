//
//  PlatformInterfaseSuffix.swift
//  OfficeeiOSCore
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

enum PlatformInterfaseSuffix: String {
  case `default` = ""
  case iPhone = "~iPhone"
  case iPad = "~iPad"
  
  static func suffixFor(idiom: UIUserInterfaceIdiom) -> Self {
    switch idiom {
    case .phone:
      return iPhone
    case .pad:
      return .iPad
    default:
      return .default
    }
  }
}

extension PlatformInterfaseSuffix {
  static func addSuffixFor(
    interfaceId: String,
    withIdiom idiom: UIUserInterfaceIdiom
  ) -> String {
    interfaceId + Self.suffixFor(idiom: idiom).rawValue
  }
}
