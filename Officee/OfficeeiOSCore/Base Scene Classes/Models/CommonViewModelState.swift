//
//  CommonViewModelState.swift
//  OfficeeiOSCore
//
//  Created by Valeriy L on 20.10.2022.
//

import Foundation

public enum CommonViewModelState: Equatable {
  case initial
  case loading
  case dataLoaded
  case error(Error)
  
  public static func == (lhs: CommonViewModelState, rhs: CommonViewModelState) -> Bool {
    switch (lhs, rhs) {
    case (.initial, .initial),
        (.loading, .loading),
        (.dataLoaded, .dataLoaded),
        (.error, .error):
      return true
      
    default:
      return false
    }
  }
}
