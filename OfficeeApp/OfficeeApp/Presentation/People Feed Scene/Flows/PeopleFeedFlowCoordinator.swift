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
    let peopleFeedController = sceneFactory.peopleFeedController()
    let navigationController = UINavigationController(rootViewController: peopleFeedController)
    self.navigationController = navigationController
    return navigationController
  }
}

typealias PeopleFeedFlowCoordinator = FlowCoordinator
