//
//  URLRequestFactory.swift
//  Officee
//
//  Created by Valeriy L on 23.10.2022.
//

import Foundation

/// UrlRequest factory that instantiate UrlRequest depending on context
public protocol URLRequestFactory {
  func getUrlRequest(_ urlRequest: @escaping (_ url: URL) -> URLRequest) -> URLRequest
}
