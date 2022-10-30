//
//  PeopleFeedRequest.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

struct PeopleFeedRequest: Equatable {
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

extension PeopleFeedRequest {
  static var refreshRequest: PeopleFeedRequest {
    PeopleFeedRequest(shouldRefresh: true)
  }
}
