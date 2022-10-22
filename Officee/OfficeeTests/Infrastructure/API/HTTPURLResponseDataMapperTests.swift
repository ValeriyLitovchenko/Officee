//
//  HTTPURLResponseDataMapperTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 22.10.2022.
//

import XCTest
import Officee

final class HTTPURLResponseDataMapperTests: XCTestCase {
  func test_map_throwsError_OnNon200HTTPResponse() throws {
    let anyData = anyData
    let invalidStatusCodes = [198, 203, 300, 400, 500]
    
    try invalidStatusCodes.forEach { statusCode in
      XCTAssertThrowsError(
        try HTTPURLResponseDataMapper.map(anyData, from: HTTPURLResponse(statusCode: statusCode))
      )
    }
  }
  
  func test_map_deliversReceivedNotModifiedData_On200HTTPResponse() throws {
    let anyData = anyData
    
    let mapResultData = try HTTPURLResponseDataMapper.map(anyData, from: .response_200)
    
    XCTAssertEqual(anyData, mapResultData)
  }
}
