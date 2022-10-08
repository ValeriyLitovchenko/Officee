//
//  ApiEndpoint.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public protocol ApiEndpoint {
  /// Instantiates URLRequest with baseURL
  func urlRequest(baseURL: URL) -> URLRequest
}
