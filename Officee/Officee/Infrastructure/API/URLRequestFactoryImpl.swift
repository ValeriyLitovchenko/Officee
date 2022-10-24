//
//  URLRequestFactoryImpl.swift
//  Officee
//
//  Created by Valeriy L on 23.10.2022.
//

import Foundation

public struct URLRequestFactoryImpl: URLRequestFactory {
  public let url: URL
  
  public init(url: URL) {
    self.url = url
  }
  
  public func getUrlRequest(_ urlRequest: @escaping (_ url: URL) -> URLRequest) -> URLRequest {
    urlRequest(url)
  }
}
