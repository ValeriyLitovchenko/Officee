//
//  URLSessionHTTPClient.swift
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
  private struct UnexpectedValueRepresentation: Error {}
  
  private struct URLSessionTaskWrapper: HTTPClient.Task {
    let wrappedTask: URLSessionTask
    
    func cancel() {
      wrappedTask.cancel()
    }
  }
  
  // MARK: - Properties
  
  private let session: URLSession
  
  // MARK: - Constructor
  
  public init(session: URLSession) {
    self.session = session
  }
  
  // MARK: - Functions
  
  @discardableResult
  public func get(
    from urlRequest: URLRequest,
    completion: @escaping ValueCallback<HTTPClient.Result>
  ) -> HTTPClient.Task {
    let task = session.dataTask(
      with: urlRequest,
      completionHandler: { data, repsonse, error in
        completion(HTTPClient.Result {
          if let error = error {
            throw error
          } else if let data = data,
                    let response = repsonse as? HTTPURLResponse {
            return (data, response)
          } else {
            throw UnexpectedValueRepresentation()
          }
        })
      })
    
    task.resume()
    
    return URLSessionTaskWrapper(wrappedTask: task)
  }
}
