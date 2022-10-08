//
//  CommonTableViewModelState.swift
//
//  Created by Valeriy L on 27.09.2022.
//

import Foundation

public enum CommonTableViewModelState {
  case initial
  case loading
  case dataLoaded
  case contentReady(_ content: TableSections)
  case error(Error)
  
  public static func == (lhs: CommonTableViewModelState, rhs: CommonTableViewModelState) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading),
        (.dataLoaded, .dataLoaded),
        (.contentReady, .contentReady),
        (.error, .error):
      return true
      
    default:
      return false
    }
  }
}
