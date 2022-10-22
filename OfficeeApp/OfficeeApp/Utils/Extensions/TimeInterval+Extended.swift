//
//  TimeInterval+Extended.swift
//  OfficeeApp
//
//  Created by Valeriy L on 16.10.2022.
//

import Foundation

extension TimeInterval {
  var dispatchInterval: DispatchTimeInterval {
    let microseconds = Int(self * TimeInterval(1_000_000))
    return microseconds < Int.max ?
      DispatchTimeInterval.microseconds(Int(microseconds)) :
      DispatchTimeInterval.seconds(Int(self))
  }
}
