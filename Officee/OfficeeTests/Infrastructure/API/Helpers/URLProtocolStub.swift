//
//  URLProtocolStub.swift
//  OfficeeTests
//
//  Created by Valeriy L on 22.10.2022.
//

import Foundation
import Officee

final class URLProtocolStub: URLProtocol {
  private struct STUB {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    let requestObserver: ValueCallback<URLRequest>?
  }
  
  private static var _stub: STUB?
  private static var stub: STUB? {
    get { queue.sync { _stub } }
    set { queue.sync { _stub = newValue } }
  }
  
  private static let queue = DispatchQueue(label: "URLProtocolStub.queue")
  
  static func stub(data: Data?, response: URLResponse?, error: Error?) {
    stub = STUB(data: data, response: response, error: error, requestObserver: nil)
  }
  
  static func observeRequests(observer: @escaping ValueCallback<URLRequest>) {
    stub = STUB(data: nil, response: nil, error: nil, requestObserver: observer)
  }
  
  static func removeSTUB() {
    stub = nil
  }
  
  override class func canInit(with request: URLRequest) -> Bool {
    true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }
  
  override func startLoading() {
    guard let stub = URLProtocolStub.stub else { return }
    
    if let data = stub.data {
      client?.urlProtocol(self, didLoad: data)
    }
    
    if let response = stub.response {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }
    
    if let error = stub.error {
      client?.urlProtocol(self, didFailWithError: error)
    } else {
      client?.urlProtocolDidFinishLoading(self)
    }
    
    stub.requestObserver?(request)
  }
  
  override func stopLoading() {}
}
