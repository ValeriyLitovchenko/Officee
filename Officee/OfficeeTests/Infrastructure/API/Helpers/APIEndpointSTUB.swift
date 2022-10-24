//
//  APIEndpointSTUB.swift
//  OfficeeTests
//
//  Created by Valeriy L on 23.10.2022.
//

import Foundation
import Officee

struct APIEndpointSTUB: ApiEndpoint {
  let onURLRequest: () -> URLRequest
  
  func urlRequest(url: URL) -> URLRequest {
    onURLRequest()
  }
}
