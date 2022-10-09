//
//  RoomsFeedCoordinatorFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

protocol RoomsFeedCoordinatorFactory {
  var serviceLocating: ServiceLocating { get }
  func roomsFeedCoordinator() -> RoomsFeedFlowCoordinator
}

extension RoomsFeedCoordinatorFactory {
  func roomsFeedCoordinator() -> RoomsFeedFlowCoordinator {
    RoomsFeedFlowCoordinatorImpl(
      sceneFactory: RoomsFeedSceneFactoryImpl(serviceLocating: serviceLocating))
  }
}
