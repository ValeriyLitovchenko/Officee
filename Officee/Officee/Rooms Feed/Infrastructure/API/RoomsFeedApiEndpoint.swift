//
//  RoomsFeedApiEndpoint.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public enum RoomsFeedApiEndpoint: ApiEndpoint {
  case getRooms
  
  public func urlRequest(baseURL: URL) -> URLRequest {
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    
    switch self {
    case .getRooms:
      components.path = baseURL.path + "/rooms"
    }
    
    // swiftlint:disable force_unwrapping
    return URLRequest(url: components.url!)
  }
}
