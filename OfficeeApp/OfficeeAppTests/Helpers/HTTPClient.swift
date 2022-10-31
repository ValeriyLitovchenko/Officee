//
//  HTTPClient.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Foundation
import Officee

final class HTTPClientSpy: HTTPClient {
  let error: Error?
  let response: (data: Data, response: HTTPURLResponse)?
  
  private(set) var urlRequests = [URLRequest]()
  
  init(
    error: Error?,
    response: (data: Data, response: HTTPURLResponse)?
  ) {
    self.error = error
    self.response = response
  }
  
  func get(
    from urlRequest: URLRequest,
    completion: @escaping ValueCallback<HTTPClient.Result>
  ) -> HTTPClient.Task {
    urlRequests.append(urlRequest)
    
    if let error = error {
      completion(.failure(error))
    }
    if let response = response {
      completion(.success(response))
    }
    
    return DummyCancellable()
  }
}

struct DummyCancellable: Cancellable {
  func cancel() {}
}
