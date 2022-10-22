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
}
