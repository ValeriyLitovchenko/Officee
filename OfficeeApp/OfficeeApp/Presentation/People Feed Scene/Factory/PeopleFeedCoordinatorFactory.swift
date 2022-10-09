//
//  PeopleFeedCoordinatorFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

protocol PeopleFeedCoordinatorFactory {
  var serviceLocating: ServiceLocating { get }
  func peopleFeedCoordinator() -> PeopleFeedFlowCoordinator
}

extension PeopleFeedCoordinatorFactory {
  func peopleFeedCoordinator() -> PeopleFeedFlowCoordinator {
    PeopleFeedFlowCoordinatorImpl(sceneFactory: PeopleFeedSceneFactoryImpl(serviceLocating: serviceLocating))
  }
}
