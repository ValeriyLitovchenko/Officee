//
//  ProxyLaunchFlowFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import UIKit.UIWindow

struct ProxyLaunchFlowFactoryImpl: ProxyLaunchFlowFactory {
  let serviceLocating: ServiceLocating
  
  func proxyLaunchController(with navigationActions: ProxyLaunchNavigationActions) -> ProxyLaunchController {
    let viewModel = ProxyLaunchViewModelImpl(
      loadFeedsUseCase: serviceLocating.unsafeResolve(),
      navigationActions: navigationActions)
    return ProxyLaunchController(viewModel: viewModel)
  }
}

protocol ProxyLaunchFlowFactory: TabBarSceneCoordinatorFactory {
  var serviceLocating: ServiceLocating { get }
  func proxyLaunchController(with navigationActions: ProxyLaunchNavigationActions) -> ProxyLaunchController
}
