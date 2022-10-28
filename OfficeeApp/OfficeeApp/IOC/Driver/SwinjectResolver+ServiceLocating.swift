//
//  SwinjectResolver+ServiceLocating.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Swinject

extension Swinject.Resolver {
  func unsafeResolve<Service>() -> Service {
    unsafeResolve(Service.self)
  }
  
  func unsafeResolve<Service>(_ serviceType: Service.Type) -> Service {
    guard let service = resolve(serviceType) else {
      fatalError("Swinject.Resolver service \(serviceType) is not registered")
    }
    
    return service
  }
}
