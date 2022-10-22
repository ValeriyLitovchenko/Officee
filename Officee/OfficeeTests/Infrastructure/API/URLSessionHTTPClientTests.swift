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
    let data = anyData
    let response = HTTPURLResponse.any_response_200
    
    let receivedValues = resultValuesFor((data: data, response: response, error: nil))
    
    XCTAssertEqual(receivedValues?.data, data)
    XCTAssertEqual(receivedValues?.response.url, response.url)
    XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
  }
  
  func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
    let emptyData = Data()
    let response = HTTPURLResponse.any_response_200
    
    let receivedValues = resultValuesFor((data: nil, response: response, error: nil))
    
    XCTAssertEqual(receivedValues?.data, emptyData)
    XCTAssertEqual(receivedValues?.response.url, response.url)
    XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
  }
  
  func test_cancelGetFromURLRequestTask_cancelsURLRequest() {
    let receivedError = resultErrorFor(taskHandler: { $0.cancel() }) as NSError?
    
    XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
  }
  
  func test_getFromURLRequest_failsOnRequestError() {
    let requestError = anyNSError
    
    let receivedError = resultErrorFor((nil, nil, requestError))
    
    XCTAssertNotNil(receivedError)
  }
  
  func test_getFromURL_failsOnAllInvalidRepresentationCases() {
    XCTAssertNotNil(resultErrorFor((data: nil, response: nil, error: nil)))
    XCTAssertNotNil(resultErrorFor((data: nil, response: .nonHTTP_response, error: nil)))
    XCTAssertNotNil(resultErrorFor((data: anyData, response: nil, error: nil)))
    XCTAssertNotNil(resultErrorFor((data: anyData, response: nil, error: anyNSError)))
    XCTAssertNotNil(resultErrorFor((data: nil, response: .nonHTTP_response, error: anyNSError)))
    XCTAssertNotNil(resultErrorFor((data: nil, response: HTTPURLResponse.any_response_200, error: anyNSError)))
    XCTAssertNotNil(resultErrorFor((data: anyData, response: .nonHTTP_response, error: anyNSError)))
    XCTAssertNotNil(resultErrorFor((data: anyData, response: HTTPURLResponse.any_response_200, error: anyNSError)))
    XCTAssertNotNil(resultErrorFor((data: anyData, response: .nonHTTP_response, error: nil)))
  }
  
  // MARK: - Helpers
  
  private func resultErrorFor(
    _ values: (data: Data?, response: URLResponse?, error: Error?)? = nil,
    taskHandler: (HTTPClient.Task) -> Void = { _ in },
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Error? {
    let result = resultFor(values, taskHandler: taskHandler, file: file, line: line)
    
    switch result {
    case let .success(values):
      XCTFail("Expected failure, got \(values) instead")
      return nil
    case let .failure(error):
      return error
    }
  }
  
  private func resultValuesFor(
    _ values: (data: Data?, response: URLResponse?, error: Error?)? = nil,
    taskHandler: (HTTPClient.Task) -> Void = { _ in },
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> (data: Data, response: HTTPURLResponse)? {
    let result = resultFor(values, taskHandler: taskHandler, file: file, line: line)
    
    switch result {
    case let .success(values):
      return values
    case let .failure(error):
      XCTFail("Expected success, got \(error) instead")
      return nil
    }
  }
  
  private func resultFor(
    _ values: (data: Data?, response: URLResponse?, error: Error?)? = nil,
    taskHandler: (HTTPClient.Task) -> Void = { _ in },
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> HTTPClient.Result {
    let sut = makeSUT(file: file, line: line)
    let exp = expectation(description: "Wait for request completion")
    
    values.map { URLProtocolStub.stub(data: $0.data, response: $0.response, error: $0.error) }
    
    var receivedResult: HTTPClient.Result!
    taskHandler(sut.get(from: anyGETRequest) { result in
      receivedResult = result
      exp.fulfill()
    })
    
    wait(for: [exp], timeout: 1.0)
    
    return receivedResult
  }
  
  private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [URLProtocolStub.self]
    let session = URLSession(configuration: sessionConfiguration)
    
    let sut = URLSessionHTTPClient(session: session)
    return sut
  }
}
