//
//  ProxyLaunchFlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import UIKit

final class ProxyLaunchFlowCoordinator {
  
  // MARK: - Properties
  
  private let flowFactory: ProxyLaunchFlowFactory
  private weak var window: UIWindow?
  
  // MARK: - Constructor
  
  init(
    window: UIWindow,
    flowFactory: ProxyLaunchFlowFactory
  ) {
    self.window = window
    self.flowFactory = flowFactory
  }
  
  func start() {
    window?.rootViewController = flowFactory.proxyLaunchController()
  }
}
