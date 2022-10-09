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
  private let window: UIWindow
  
  // MARK: - Constructor
  
  init(
    window: UIWindow,
    flowFactory: ProxyLaunchFlowFactory
  ) {
    self.window = window
    self.flowFactory = flowFactory
  }
  
  func start() {
    let navigatioActions = ProxyLaunchNavigationActions(openTabBar: openTabBar)
    window.rootViewController = flowFactory.proxyLaunchController(with: navigatioActions)
  }
  
  private func openTabBar() {
    let coordinator = flowFactory.tabBarCoordinator()
    window.rootViewController = coordinator.start()
  }
}
