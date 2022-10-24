//
//  RoomsFeedApiEndpoint.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public enum RoomsFeedApiEndpoint: ApiEndpoint {
  case getRooms
  
  public func urlRequest(url: URL) -> URLRequest {
    switch self {
    case .getRooms:
      return URLRequest(url: url.appendingPathComponent("rooms"))
    }
  }
}
