//
//  PeopleFeedApiEndpointTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 24.10.2022.
//

import XCTest
import Officee

final class PeopleFeedApiEndpointTests: XCTestCase {
  func test_people_endpointRequest() {
    let url = anyURL
    
    let request = PeopleFeedApiEndpoint.getPeople.urlRequest(url: url)
    
    XCTAssertNotNil(request.url)
    XCTAssertEqual(request.url!.host, url.host)
    XCTAssertEqual(request.url!.path, "/people", "path")
  }
}
