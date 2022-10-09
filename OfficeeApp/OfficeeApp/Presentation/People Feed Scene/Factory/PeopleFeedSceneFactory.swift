//
//  PeopleFeedSceneFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

struct PeopleFeedSceneFactoryImpl: PeopleFeedSceneFactory {
  let serviceLocating: ServiceLocating
}

protocol PeopleFeedSceneFactory {
  var serviceLocating: ServiceLocating { get }
  func peopleFeedController() -> PeopleFeedController
}

extension PeopleFeedSceneFactory {
  func peopleFeedController() -> PeopleFeedController {
    let viewModel = PeopleFeedViewModel(getPeopleUseCase: serviceLocating.resolve())
    return PeopleFeedController(viewModel: viewModel)
  }
}
