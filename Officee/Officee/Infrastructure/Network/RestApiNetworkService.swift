//
//  RestApiNetworkService.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

/// Rest api service for client-server interactions
public final class RestApiNetworkService: NetworkService {
  
  // MARK: - Properties
  
  private let baseURL: URL
  private let httpClient: HTTPClient
  
  // MARK: - Constructor
  
  public init(
    baseURL: URL,
    httpClient: HTTPClient
  ) {
    self.baseURL = baseURL
    self.httpClient = httpClient
  }
  
  // MARK: - Functions
  
  @discardableResult
  public func request(
    urlRequest: URLRequestFactoryMethod,
    completion: @escaping ValueCallback<NetworkService.Result>
  ) -> NetworkService.Task {
    httpClient.get(from: urlRequest(baseURL), completion: completion)
  }
}
