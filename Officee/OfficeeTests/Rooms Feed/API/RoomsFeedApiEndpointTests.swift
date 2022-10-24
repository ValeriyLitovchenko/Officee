//
//  RoomsFeedApiEndpointTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 24.10.2022.
//

import XCTest
import Officee

final class RoomsFeedApiEndpointTests: XCTestCase {
  func test_rooms_endpointRequest() {
    let url = anyURL
    
    let request = RoomsFeedApiEndpoint.getRooms.urlRequest(url: url)
    
    XCTAssertNotNil(request.url)
    XCTAssertEqual(request.url!.host, url.host)
    XCTAssertEqual(request.url!.path, "/rooms", "path")
  }
}
