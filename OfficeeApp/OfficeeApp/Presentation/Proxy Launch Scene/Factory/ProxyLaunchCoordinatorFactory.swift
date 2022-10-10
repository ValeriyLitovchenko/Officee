//
//  ProxyLaunchCoordinatorFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import UIKit.UIWindow

protocol ProxyLaunchCoordinatorFactory {
  var serviceLocating: ServiceLocating { get }
  func flowCoordinator(with window: UIWindow) -> ProxyLaunchFlowCoordinator
}

extension ProxyLaunchCoordinatorFactory {
  func flowCoordinator(with window: UIWindow) -> ProxyLaunchFlowCoordinator {
    ProxyLaunchFlowCoordinatorImpl(
      window: window,
      flowFactory: ProxyLaunchFlowFactoryImpl(serviceLocating: serviceLocating))
  }
}
