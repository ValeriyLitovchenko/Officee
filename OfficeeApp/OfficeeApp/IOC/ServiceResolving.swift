//
//  ServiceResolver.swift
//  OfficeeApp
//
//  Created by Valeriy L on 28.10.2022.
//

import Foundation

protocol ServiceResolving {
  /// Resolve registered `Service`. Will cause crash if `Service` not registered.
  func unsafeResolve<Service>() -> Service
  /// Resolve registered `Service` for `serviceType`. Will cause crash if `Service` not registered.
  func unsafeResolve<Service>(_ serviceType: Service.Type) -> Service
  
  /// Resolve registered `Service`.
  func resolve<Service>() -> Service?
  /// Resolve registered `Service`.
  func resolve<Service>(_ serviceType: Service.Type) -> Service?
}
