//
//  CombineHelpers.swift
//  OfficeeApp
//
//  Created by Valeriy L on 20.10.2022.
//

import Foundation
import Combine

extension Publisher {
  func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
    receive(on: DispatchQueue.main).eraseToAnyPublisher()
  }
  
  static func emptyAnyPublisher() -> AnyPublisher<Output, Failure> {
    EmptyAnyPublisher()
  }
  
  func tryFlatMap<P: Publisher>(
      maxPublishers: Subscribers.Demand = .unlimited,
      _ transform: @escaping (Output) throws -> P
  ) -> Publishers.FlatMap<AnyPublisher<P.Output, Error>, Self> {
    flatMap(
      maxPublishers: maxPublishers,
      { input -> AnyPublisher<P.Output, Error> in
        do {
          return try transform(input)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
        } catch {
          return Fail(outputType: P.Output.self, failure: error)
            .eraseToAnyPublisher()
        }
      })
  }
}

extension Publisher where Failure == Swift.Error {
  func handleResult(_ result: @escaping (Output) throws -> Void) -> AnyPublisher<Output, Failure> {
    tryMap { output in
      try result(output)
      return output
    }
    .eraseToAnyPublisher()
  }
  
  static func errorAnyPublisher(_ error: Error) -> AnyPublisher<Output, Failure> {
    Fail(error: error)
      .eraseToAnyPublisher()
  }
  
}

func JustAnyPublisher<Output, Failure>(_ output: Output) -> AnyPublisher<Output, Failure> {
  Just(output)
    .setFailureType(to: Failure.self)
    .eraseToAnyPublisher()
}

func EmptyAnyPublisher<Output, Failure>() -> AnyPublisher<Output, Failure> {
  Empty<Output, Failure>().eraseToAnyPublisher()
}
