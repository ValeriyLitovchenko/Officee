//
//  NetworkService+Combine.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import Combine
import Officee

extension NetworkService {
  typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
  
  func getPublisher(from urlRequest: @escaping URLRequestFactoryMethod) -> NetworkService.Publisher {
    Deferred {
      Future { promise in
        request(
          urlRequest: urlRequest,
          completion: promise)
      }
    }
    .eraseToAnyPublisher()
  }
}
