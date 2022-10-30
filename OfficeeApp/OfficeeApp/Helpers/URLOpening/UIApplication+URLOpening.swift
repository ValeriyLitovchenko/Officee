//
//  UIApplication+URLOpening.swift
//  OfficeeApp
//
//  Created by Valeriy L on 30.10.2022.
//

import UIKit.UIApplication

extension UIApplication: URLOpening {
  enum Error: Swift.Error {
    case cantOpenURL
  }
  
  func open(url: URL) throws {
    guard canOpenURL(url) else {
      throw UIApplication.Error.cantOpenURL
    }
    
    open(url, options: [:])
  }
}
