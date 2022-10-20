//
//  PlatformFlowUseCase.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore

struct PlatformFlowUseCase {
  func invoke(
    iPhoneFlow: VoidCallback,
    iPadFlow: VoidCallback
  ) {
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      iPadFlow()
    case .phone:
      iPhoneFlow()
    default:
      fatalError("Not supported")
    }
  }
  
  static func invoke(
    iPhoneFlow: VoidCallback? = nil,
    iPadFlow: VoidCallback? = nil
  ) {
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      iPadFlow?()
    case .phone:
      iPhoneFlow?()
    default:
      fatalError("Not supported")
    }
  }
}
