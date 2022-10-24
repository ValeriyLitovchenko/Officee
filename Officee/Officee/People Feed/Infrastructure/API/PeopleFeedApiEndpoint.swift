//
//  PeopleFeedApiEndpoint.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public enum PeopleFeedApiEndpoint: ApiEndpoint {
  case getPeople
  
  public func urlRequest(url: URL) -> URLRequest {
    switch self {
    case .getPeople:
      return URLRequest(url: url.appendingPathComponent("people"))
    }
  }
}
