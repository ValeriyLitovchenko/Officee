//
//  RoomsFeedFlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

final class RoomsFeedFlowCoordinatorImpl: RoomsFeedFlowCoordinator {
  
  // MARK: - Properties
  
  private let sceneFactory: RoomsFeedSceneFactory
  private weak var navigationController: UINavigationController?
  
  // MARK: - Constructor
  
  init(sceneFactory: RoomsFeedSceneFactory) {
    self.sceneFactory = sceneFactory
  }
  
  // MARK: - Functions
  
  @discardableResult
  func start() -> UIViewController {
    let roomsFeedController = sceneFactory.roomsFeedController()
    let navigationController = UINavigationController(rootViewController: roomsFeedController)
    self.navigationController = navigationController
    return navigationController
  }
}

typealias RoomsFeedFlowCoordinator = FlowCoordinator
