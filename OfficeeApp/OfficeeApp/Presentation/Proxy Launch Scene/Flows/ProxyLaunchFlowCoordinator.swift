//
//  ProxyLaunchFlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import UIKit

final class ProxyLaunchFlowCoordinatorImpl: ProxyLaunchFlowCoordinator, ToastViewPresenter {
  
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
  
  // MARK: - Functions
  
  @discardableResult
  func start() -> UIViewController {
    let navigatioActions = ProxyLaunchNavigationActions(
      openTabBar: openTabBar,
      showToastMessage: showAutohidingToastView(with:))
    let controller = flowFactory.proxyLaunchController(with: navigatioActions)
    window.rootViewController = controller
    return controller
  }
  
  // MARK: - Private Functions
  
  private func openTabBar() {
    let coordinator = flowFactory.tabBarCoordinator()
    window.rootViewController = coordinator.start()
  }
}

typealias ProxyLaunchFlowCoordinator = FlowCoordinator
