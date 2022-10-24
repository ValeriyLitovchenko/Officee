//
//  HTTPClient+Combine.swift
//  OfficeeApp
//
//  Created by Valeriy L on 23.10.2022.
//

import Foundation
import Combine
import Officee

extension HTTPClient {
  typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
  
  func getPublisher(from urlRequest: URLRequest) -> HTTPClient.Publisher {
    Deferred {
      Future { promise in
        get(from: urlRequest, completion: promise)
      }
    }
    .eraseToAnyPublisher()
  }
}
