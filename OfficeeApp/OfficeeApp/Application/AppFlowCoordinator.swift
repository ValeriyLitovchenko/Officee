//
//  AppFlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import UIKit

final class AppFlowCoordinator {
  
  // MARK: - Properties
  
  let window: UIWindow
  let appFlowFactory: AppFlowFactory
  
  // MARK: - Constructor
  
  init(
    window: UIWindow,
    appFlowFactory: AppFlowFactory
  ) {
    self.window = window
    self.appFlowFactory = appFlowFactory
  }
  
  // MARK: - Functions
  
  func start() {
    appFlowFactory.flowCoordinator(with: window).start()
  }
}
