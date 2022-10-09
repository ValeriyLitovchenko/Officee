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
  func roomsFeedController() -> RoomsFeedController
}

extension RoomsFeedSceneFactory {
  func roomsFeedController() -> RoomsFeedController {
    let viewModel = RoomsFeedViewModel(getRoomsUseCase: serviceLocating.resolve())
    return RoomsFeedController(viewModel: viewModel)
  }
}
