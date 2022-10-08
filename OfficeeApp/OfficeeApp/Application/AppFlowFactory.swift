//
//  AppFlowFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

struct AppFlowFactoryImpl: AppFlowFactory {
  var serviceLocating: ServiceLocating
}

typealias AppFlowFactory = ProxyLaunchCoordinatorFactory
