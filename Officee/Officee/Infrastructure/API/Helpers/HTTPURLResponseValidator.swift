//
//  HTTPURLResponseValidator.swift
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

/// Mechanism for validating response by checking status code
public enum HTTPURLResponseValidator {
  private enum Error: Swift.Error {
    case unsupportedStatusCode(Int)
  }
  
  /// Checks response status code
  /// - Parameters:
  ///   - response: url response
  ///   - ignoringCodes: status codes that can be omitted while validation
  public static func validate(
    _ response: HTTPURLResponse,
    ignore ignoringCodes: [Int]? = nil
  ) throws {
    guard response.isSuccessful else {
      if let ignoringCodes = ignoringCodes,
         ignoringCodes.contains(response.statusCode) {
        return
      }
      throw HTTPURLResponseValidator.Error.unsupportedStatusCode(response.statusCode)
    }
  }
}
