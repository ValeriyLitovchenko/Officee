//
//  PeopleFeedRequest.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

struct PeopleFeedRequest {
  let query: String?
  let shouldRefresh: Bool
}

extension PeopleFeedRequest {
  static var refreshRequest: PeopleFeedRequest {
    PeopleFeedRequest(query: nil, shouldRefresh: true)
  }
}
