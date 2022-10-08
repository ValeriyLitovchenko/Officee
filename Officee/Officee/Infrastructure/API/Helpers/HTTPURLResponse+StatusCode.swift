//
//  HTTPURLResponse+StatusCode.swift
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

extension HTTPURLResponse {
  private static var OK_200: Int { 200 }
  
  /// Checks that response statusCode is 200
  var isSuccessful: Bool {
    statusCode == HTTPURLResponse.OK_200
  }
}
