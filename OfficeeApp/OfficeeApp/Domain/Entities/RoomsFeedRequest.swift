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
}

extension RoomsFeedRequest {
  static var refreshRequest: RoomsFeedRequest {
    RoomsFeedRequest(query: nil, shouldRefresh: true)
  }
}
