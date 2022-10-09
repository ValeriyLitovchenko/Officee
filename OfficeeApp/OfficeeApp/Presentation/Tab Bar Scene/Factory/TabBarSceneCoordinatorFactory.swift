//
//  TabBarSceneCoordinatorFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

protocol TabBarSceneCoordinatorFactory {
  var serviceLocating: ServiceLocating { get }
  func tabBarCoordinator() -> TabBarSceneFlowCoordinator
}

extension TabBarSceneCoordinatorFactory {
  func tabBarCoordinator() -> TabBarSceneFlowCoordinator {
    TabBarSceneFlowCoordinatorImpl(
      sceneFactory: TabBarSceneFactoryImpl(serviceLocating: serviceLocating))
  }
}
