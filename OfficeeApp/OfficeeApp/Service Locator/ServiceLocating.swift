//
//  ServiceLocating.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

protocol ServiceLocating {
  func resolve<Service, Arg1, Arg2>(arg1: Arg1, arg2: Arg2) -> Service
  func resolve<Service, Arg1>(arg: Arg1) -> Service
  func resolve<Service>() -> Service
  @discardableResult
  func resolve<Service>(_ serviceType: Service.Type) -> Service
}
