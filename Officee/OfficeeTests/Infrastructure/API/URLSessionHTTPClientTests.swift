//
//  URLSessionHTTPClientTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 22.10.2022.
//

import XCTest
import Officee

final class URLSessionHTTPClientTests: XCTestCase {
  override func tearDown() {
    super.tearDown()
    
    URLProtocolStub.removeSTUB()
  }
  
  func test_getFromURLRequest_performGETRequest() {
    let getRequest = anyGETRequest
    let exp = expectation(description: "Wait for request")
    
    URLProtocolStub.observeRequests { request in
      XCTAssertEqual(request, getRequest)
      exp.fulfill()
    }
    
    makeSUT().get(from: getRequest) { _ in }
    
    wait(for: [exp], timeout: 1.0)
  }
  
  // MARK: - Helpers
  
  private func makeSUT() -> URLSessionHTTPClient {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [URLProtocolStub.self]
    let session = URLSession(configuration: sessionConfiguration)
    
    let sut = URLSessionHTTPClient(session: session)
    return sut
  }
}
