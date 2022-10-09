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
    let peopleFeed = sceneFactory.peopleFeedCoordinator().start()
    let roomsFeed = sceneFactory.roomsFeedCoordinator().start()
    let tabBarController = UITabBarController()
    tabBarController.tabBar.tintColor = .systemRed
    tabBarController.setViewControllers(
      [
        peopleFeed,
        roomsFeed
      ],
      animated: false)
    return tabBarController
  }
}

typealias TabBarSceneFlowCoordinator = FlowCoordinator
