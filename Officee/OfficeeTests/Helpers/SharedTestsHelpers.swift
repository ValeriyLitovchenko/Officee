//
//  SharedTestsHelpers.swift
//  OfficeeTests
//
//  Created by Valeriy L on 22.10.2022.
//

import Foundation
import Officee

var anyURL: URL {
  URL(string: "https://any-url.com")!
}

var anyGETRequest: URLRequest {
  var request = URLRequest(url: anyURL)
  request.httpMethod = URLRequest.HTTPMethod.GET
  return request
}

var anyData: Data {
  Data("any dta".utf8)
}

var anyNSError: Error {
  NSError(domain: "any error", code: .zero)
}

extension HTTPURLResponse {
  convenience init(statusCode: Int) {
    self.init(url: anyURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
  }
  
  static var any_response_200: HTTPURLResponse {
    self.init(url: anyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
  }
}
