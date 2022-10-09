//
//  PeopleFeedFlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

final class PeopleFeedFlowCoordinatorImpl: PeopleFeedFlowCoordinator {
  
  // MARK: - Properties
  
  private let sceneFactory: PeopleFeedSceneFactory
  private weak var navigationController: UINavigationController?
  
  // MARK: - Constructor
  
  init(sceneFactory: PeopleFeedSceneFactory) {
    self.sceneFactory = sceneFactory
  }
  
  // MARK: - Functions
  
  @discardableResult
  func start() -> UIViewController {
    let navigationActions = PeopleFeedNavigationActions(openPersonDetails: openPersonDetails(_:))
    let peopleFeedController = sceneFactory.peopleFeedController(with: navigationActions)
    let navigationController = UINavigationController(rootViewController: peopleFeedController)
    self.navigationController = navigationController
    return navigationController
  }
  
  // MARK: - Private Functions
  
  private func openPersonDetails(_ inputModel: PersonDetailsInput) {
    let personDetails = sceneFactory.personDetailsController(with: inputModel)
    personDetails.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(personDetails, animated: true)
  }
}

typealias PeopleFeedFlowCoordinator = FlowCoordinator
