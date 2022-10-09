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
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = appFlowCoordinator.window
    appFlowCoordinator.start()
    window?.makeKeyAndVisible()
    
    setupNavigationBarAppearance()
    return true
  }
  
  // MARK: - Private functions
  private func setupNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemGray6
    appearance.backgroundEffect = .none
    
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().tintColor = DefinedColors.guardsmanRed.color
    
    UITabBar.appearance().tintColor = DefinedColors.guardsmanRed.color
  }
}
