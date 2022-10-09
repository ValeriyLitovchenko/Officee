//
//  FlowCoordinator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

protocol FlowCoordinator {
  @discardableResult
  func start() -> UIViewController
}
