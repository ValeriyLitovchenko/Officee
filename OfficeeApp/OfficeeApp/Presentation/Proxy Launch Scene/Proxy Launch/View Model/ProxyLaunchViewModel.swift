//
//  ProxyLaunchViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import OfficeeiOSCore

protocol ProxyLaunchViewModel {
  var statePublisher: ValuePublisher<ProxyLaunchViewModelState> { get }
  
  func loadData()
}

typealias ProxyLaunchViewModelState = CommonViewModelState
