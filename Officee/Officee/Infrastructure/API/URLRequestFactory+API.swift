//
//  URLRequestFactory+API.swift
//  Officee
//
//  Created by Valeriy L on 23.10.2022.
//

import Foundation

public extension URLRequestFactory {
  func requestFor(api: ApiEndpoint) -> URLRequest {
    getUrlRequest(api.urlRequest(url:))
  }
}
