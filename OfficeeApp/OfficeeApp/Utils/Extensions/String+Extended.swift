//
//  String+Extended.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

extension String {
  /// Returns nil value if string is empty
  var nilIfEmpty: String? {
    isEmpty ? nil : self
  }
}
