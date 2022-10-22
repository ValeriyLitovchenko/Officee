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
    let requestObserver: ValueCallback<URLRequest>?
  }
  
  private static var _stub: STUB?
  private static var stub: STUB? {
    get { queue.sync { _stub } }
    set { queue.sync { _stub = newValue } }
  }
  
  private static let queue = DispatchQueue(label: "URLProtocolStub.queue")
  
  static func observeRequests(observer: @escaping ValueCallback<URLRequest>) {
    stub = STUB(requestObserver: observer)
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
    
    stub.requestObserver?(request)
  }
  
  override func stopLoading() {}
}
