//
//  ProxyLaunchViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

protocol ProxyLaunchViewModel {
  var isLoading: ValuePublisher<Bool> { get }
  
  func loadData()
}
