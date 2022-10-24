//
//  URLRequestFactoryTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 23.10.2022.
//

import XCTest
import Officee

final class URLRequestFactoryTests: XCTestCase {
  func test_factoryReturnsURLRerquest_withNotModifiedURL() {
    let url = anyURL
    let sut = URLRequestFactoryImpl(url: url)
    
    let receivedRequest = sut.getUrlRequest { URLRequest(url: $0) }
    
    XCTAssertEqual(receivedRequest.url, url)
  }
  
  func test_factoryReturnsNotModifiedURLRequest() {
    let url = anyURL
    let expectedURLRequest = URLRequest(url: url)
    let sut = URLRequestFactoryImpl(url: url)
    
    let receivedRequest = sut.getUrlRequest { _ in
      expectedURLRequest
    }
    
    XCTAssertEqual(receivedRequest, expectedURLRequest)
  }
  
  func test_factoryReturnsNotModifiedURLRequest_forAPIEndpoint() {
    let url = anyURL
    let expectedURLRequest = URLRequest(url: url)
    let api = APIEndpointSTUB { expectedURLRequest }
    let sut = URLRequestFactoryImpl(url: url)
    
    let receivedRequest = sut.requestFor(api: api)
    
    XCTAssertEqual(receivedRequest, expectedURLRequest)
  }
}
