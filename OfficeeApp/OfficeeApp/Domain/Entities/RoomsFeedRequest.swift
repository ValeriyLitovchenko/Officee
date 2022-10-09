//
//  RoomsFeedRequest.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

struct RoomsFeedRequest {
  let query: String?
  let shouldRefresh: Bool
  
  init(
    query: String? = nil,
    shouldRefresh: Bool
  ) {
    self.query = query
    self.shouldRefresh = shouldRefresh
  }
}

extension RoomsFeedRequest {
  static var refreshRequest: RoomsFeedRequest {
    RoomsFeedRequest(shouldRefresh: true)
  }
}
