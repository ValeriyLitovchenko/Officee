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
    let request = anyGETRequest
    let exp = expectation(description: "Wait for request")
    
    URLProtocolStub.observeRequests { request in
      XCTAssertEqual(request, request)
      exp.fulfill()
    }
    
    makeSUT().get(from: request) { _ in }
    
    wait(for: [exp], timeout: 1.0)
  }
  
  func test_getFromURLRequest_succeedsOnHTTPURLResponseWithData() {
    let request = anyGETRequest
    let data = anyData
    let response = HTTPURLResponse.any_response_200
    let exp = expectation(description: "Wait for request completion")
    
    URLProtocolStub.stub(data: data, response: response, error: nil)
    
    var receivedValues: (data: Data, response: HTTPURLResponse)?
    makeSUT().get(from: request) { result in
      switch result {
      case let .success(values):
        receivedValues = values
      case let .failure(error):
        XCTFail("Expected success, got \(error) instead")
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 1.0)
    
    XCTAssertEqual(receivedValues?.data, data)
    XCTAssertEqual(receivedValues?.response.url, response.url)
    XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
  }
  
  func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
    let request = anyGETRequest
    let emptyData = Data()
    let response = HTTPURLResponse.any_response_200
    let exp = expectation(description: "Wait for request completion")
    
    URLProtocolStub.stub(data: nil, response: response, error: nil)
    
    var receivedValues: (data: Data, response: HTTPURLResponse)?
    makeSUT().get(from: request) { result in
      switch result {
      case let .success(values):
        receivedValues = values
      case let .failure(error):
        XCTFail("Expected success, got \(error) instead")
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 1.0)
    
    XCTAssertEqual(receivedValues?.data, emptyData)
    XCTAssertEqual(receivedValues?.response.url, response.url)
    XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
  }
  
  func test_cancelGetFromURLRequestTask_cancelsURLRequest() {
    let request = anyGETRequest
    let exp = expectation(description: "Wait for request completion")
    
    var receivedError: NSError?
    
    makeSUT().get(from: request) { result in
      switch result {
      case let .failure(error):
        receivedError = error as NSError?
        
      case let .success(result):
        XCTFail("Expected failure, got \(result) instead.")
      }
      exp.fulfill()
    }.cancel()
    
    wait(for: [exp], timeout: 1.0)
    
    XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
  }
  
  func test_getFromURLRequest_failsOnRequestError() {
    let request = anyGETRequest
    let error = anyNSError
    let exp = expectation(description: "Wait for request completion")
    
    URLProtocolStub.stub(data: nil, response: nil, error: error)
    
    var receivedError: NSError?
    
    makeSUT().get(from: request) { result in
      switch result {
      case let .failure(error):
        receivedError = error as NSError?
        
      case let .success(result):
        XCTFail("Expected failure, got \(result) instead.")
      }
      exp.fulfill()
    }.cancel()
    
    wait(for: [exp], timeout: 1.0)
    
    XCTAssertNotNil(receivedError)
  }
  
  // MARK: - Helpers
  
  private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> URLSessionHTTPClient {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [URLProtocolStub.self]
    let session = URLSession(configuration: sessionConfiguration)
    
    let sut = URLSessionHTTPClient(session: session)
    return sut
  }
}
