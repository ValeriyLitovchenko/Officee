//
//  AppDelegate.swift
//  OfficeeApp
//
//  Created by Valeriy L on 07.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
  private lazy var appFlowCoordinator = AppFlowCoordinator(
    window: UIWindow(frame: UIScreen.main.bounds),
    appFlowFactory: AppFlowFactoryImpl(
      serviceLocating: SwinjectServiceLocator()))
  
  // MARK: - Functions
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = appFlowCoordinator.window
    appFlowCoordinator.start()
    window?.makeKeyAndVisible()
    
    return true
  }
}
