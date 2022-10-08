//
//  NetworkService.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

/// Base interface for client-server interactions service
public protocol NetworkService {
  typealias Task = Cancellable
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
  /// Factory method for instantiating URLRequest
  typealias URLRequestFactoryMethod = ((_ baseURL: URL) -> URLRequest)
  
  /// Performs request provided by URLRequestFactoryMethod with propagating result through completion closure
  @discardableResult
  func request(
    urlRequest: URLRequestFactoryMethod,
    completion: @escaping ValueCallback<NetworkService.Result>
  ) -> NetworkService.Task
}
