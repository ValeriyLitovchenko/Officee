//
//  OperationStatePublisher.swift
//  OfficeeApp
//
//  Created by Valeriy L on 20.10.2022.
//

import Foundation

protocol OperationStatePublisher {
  func publishInProgress()
  func publishFinished()
  func publish(error: Error)
}
