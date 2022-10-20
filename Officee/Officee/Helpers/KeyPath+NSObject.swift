//
//  KeyPath+NSObject.swift
//  Officee
//
//  Created by Valeriy L on 20.10.2022.
//

import Foundation

/*
 Since compiler gives `Ambiguous reference to member 'id'` error for `#keyPath(ManagedObject.id)`
 use this `KeyPath.string`
*/
public extension KeyPath where Root: NSObject {
  var string: String {
    NSExpression(forKeyPath: self).keyPath
  }
}
