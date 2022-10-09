//
//  TabBarSceneFlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

final class TabBarSceneFlowCoordinatorImpl: TabBarSceneFlowCoordinator {
  
  // MARK: - Properties
  
  let sceneFactory: TabBarSceneFactory
  
  // MARK: - Constructor
  
  init(sceneFactory: TabBarSceneFactory) {
    self.sceneFactory = sceneFactory
  }
  
  // MARK: - Functions
  
  @discardableResult
  func start() -> UIViewController {
    let tabBarController = UITabBarController()
    let peopleFeedCoordinator = sceneFactory.peopleFeedCoordinator()
    tabBarController.setViewControllers([peopleFeedCoordinator.start()], animated: false)
    return tabBarController
  }
}

typealias TabBarSceneFlowCoordinator = FlowCoordinator
