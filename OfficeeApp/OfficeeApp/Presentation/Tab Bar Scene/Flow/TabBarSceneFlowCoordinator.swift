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
    let peopleFeed = sceneFactory.peopleFeedCoordinator().start()
    peopleFeed.tabBarItem = UITabBarItem(title: peopleFeed.title, image: .add, tag: .zero)
    let roomsFeed = sceneFactory.roomsFeedCoordinator().start()
    roomsFeed.tabBarItem = UITabBarItem(title: peopleFeed.title, image: .actions, tag: .zero)
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
