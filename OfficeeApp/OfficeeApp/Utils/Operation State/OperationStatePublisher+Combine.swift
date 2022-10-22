//
//  OperationStatePublisher+Combine.swift
//  OfficeeApp
//
//  Created by Valeriy L on 20.10.2022.
//

import Combine

extension Publisher {
  func add(operationStatePublisher: OperationStatePublisher) -> AnyPublisher<Output, Failure> {
    handleEvents(receiveSubscription: { _ in
      operationStatePublisher.publishInProgress()
    }, receiveOutput: { _ in
      operationStatePublisher.publishFinished()
    }, receiveCompletion: { completion in
      guard case let .failure(error) = completion else { return }
      
      operationStatePublisher.publish(error: error)
    }, receiveCancel: {
      operationStatePublisher.publishFinished()
    })
    .eraseToAnyPublisher()
  }
}
