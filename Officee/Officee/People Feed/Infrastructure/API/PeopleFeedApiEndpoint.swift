//
//  PeopleFeedApiEndpoint.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public enum PeopleFeedApiEndpoint: ApiEndpoint {
  case getPeople
  
  public func urlRequest(baseURL: URL) -> URLRequest {
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    
    switch self {
    case .getPeople:
      components.path = baseURL.path + "/people"
    }
    
    // swiftlint:disable force_unwrapping
    return URLRequest(url: components.url!)
  }
}
