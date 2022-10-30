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
  func peopleFeedController(with navigationActions: PeopleFeedNavigationActions) -> PeopleFeedController
  func personDetailsController(
    with inputModel: PersonDetailsInput,
    navigationActions: PersonDetailsNavigationActions
  ) -> PersonDetailsController
}

extension PeopleFeedSceneFactory {
  func peopleFeedController(with navigationActions: PeopleFeedNavigationActions) -> PeopleFeedController {
    let viewModel = PeopleFeedViewModel(
      getPeopleUseCase: serviceLocating.unsafeResolve(),
      navigationActions: navigationActions)
    return PeopleFeedController(viewModel: viewModel)
  }
  
  func personDetailsController(
    with inputModel: PersonDetailsInput,
    navigationActions: PersonDetailsNavigationActions
  ) -> PersonDetailsController {
    let viewModel = PersonDetailsViewModelImpl(
      inputModel: inputModel,
      sendEmailUseCase: serviceLocating.unsafeResolve(),
      navigationActions: navigationActions)
    return PersonDetailsController(viewModel: viewModel)
  }
}
