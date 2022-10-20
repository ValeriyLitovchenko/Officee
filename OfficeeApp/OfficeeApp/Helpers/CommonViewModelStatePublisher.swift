//
//  CommonViewModelStatePublisher.swift
//  OfficeeApp
//
//  Created by Valeriy L on 20.10.2022.
//

import OfficeeiOSCore
import Combine

struct CommonViewModelStatePublisher: OperationStatePublisher {
  let publisher: ValueSubject<CommonViewModelState>
  
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

extension ValueSubject where Output == CommonViewModelState, Failure == Never {
  var statePublisher: OperationStatePublisher {
    CommonViewModelStatePublisher(publisher: self)
  }
}
