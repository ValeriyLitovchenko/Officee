//
//  NibInstantiable.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/// Interface for instantiating nib file for UI elements
public protocol NibInstantiable: NSObjectProtocol {
  static var nib: UINib { get }
}

public extension NibInstantiable {
  static var nib: UINib {
    let nibName = String(describing: self)
    let platformOrientedNibName = PlatformInterfaseSuffix.addSuffixFor(
      interfaceId: nibName,
      withIdiom: UIDevice.current.userInterfaceIdiom
    )
    
    guard Bundle.main.path(
            forResource: platformOrientedNibName,
            ofType: "nib") != nil else {
      
      guard Bundle.main.path(
              forResource: nibName,
              ofType: "nib") != nil else {
        fatalError("Interface instructions (xib file) does not exist for \(nibName)")
      }
      
      return UINib(nibName: nibName, bundle: nil)
    }
    
    return UINib(nibName: platformOrientedNibName, bundle: nil)
  }
}
