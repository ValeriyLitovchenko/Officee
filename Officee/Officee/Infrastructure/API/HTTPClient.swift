//
//  HTTPClient.swift
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

/// Base interface for network client
public protocol HTTPClient {
  typealias Task = Cancellable
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
  
  /// Performs cancelable network request with success/failure result on completion
  @discardableResult
  func get(
    from urlRequest: URLRequest,
    completion: @escaping ValueCallback<HTTPClient.Result>
  ) -> HTTPClient.Task
}
