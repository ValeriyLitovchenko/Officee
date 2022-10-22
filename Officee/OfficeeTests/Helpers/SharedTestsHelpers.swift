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

extension HTTPURLResponse {
  convenience init(statusCode: Int) {
    self.init(url: anyURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
  }
  
  static var response_200: HTTPURLResponse {
    HTTPURLResponse(statusCode: 200)
  }
}
