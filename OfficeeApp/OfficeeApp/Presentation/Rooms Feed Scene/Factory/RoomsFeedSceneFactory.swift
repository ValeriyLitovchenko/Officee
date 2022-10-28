//
//  RoomsFeedSceneFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

struct RoomsFeedSceneFactoryImpl: RoomsFeedSceneFactory {
  let serviceLocating: ServiceLocating
}

protocol RoomsFeedSceneFactory {
  var serviceLocating: ServiceLocating { get }
  func roomsFeedController(with navigationActions: RoomsFeedNavigationActions) -> RoomsFeedController
}

extension RoomsFeedSceneFactory {
  func roomsFeedController(with navigationActions: RoomsFeedNavigationActions) -> RoomsFeedController {
    let viewModel = RoomsFeedViewModel(
      getRoomsUseCase: serviceLocating.unsafeResolve(),
      navigationActions: navigationActions)
    return RoomsFeedController(viewModel: viewModel)
  }
}
