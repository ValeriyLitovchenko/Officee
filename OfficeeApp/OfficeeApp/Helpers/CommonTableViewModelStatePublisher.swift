//
//  CommonTableViewModelStatePublisher.swift
//  OfficeeApp
//
//  Created by Valeriy L on 20.10.2022.
//

import OfficeeiOSCore
import Combine

struct CommonTableViewModelStatePublisher: OperationStatePublisher {
  let publisher: ValueSubject<CommonTableViewModelState>
  
  func publishInProgress() {
    publisher.send(.loading)
  }
  
  func publishFinished() {
    publisher.send(.dataLoaded)
  }
  
  func publish(error: Error) {
    publisher.send(.error(error))
  }
}

extension ValueSubject where Output == CommonTableViewModelState, Failure == Never {
  var statePublisher: OperationStatePublisher {
    CommonTableViewModelStatePublisher(publisher: self)
  }
}
