//
//  ProxyLaunchFlowFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import UIKit.UIWindow

struct ProxyLaunchFlowFactoryImpl: ProxyLaunchFlowFactory {
  let serviceLocating: ServiceLocating
  
  func proxyLaunchController() -> ProxyLaunchController {
    let viewModel = ProxyLaunchViewModelImpl(loadFeedsUseCase: serviceLocating.resolve())
    return ProxyLaunchController(viewModel: viewModel)
  }
}

protocol ProxyLaunchFlowFactory {
  var serviceLocating: ServiceLocating { get }
  func proxyLaunchController() -> ProxyLaunchController
}
