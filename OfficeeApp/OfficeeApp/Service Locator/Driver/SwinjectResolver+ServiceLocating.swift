//
//  SwinjectResolver+ServiceLocating.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Swinject

extension Swinject.Resolver {
  func resolve<Service>() -> Service {
    guard let service = resolve(Service.self) else {
      fatalError("Swinject.Resolver service \(Service.self) is not registered")
    }
    
    return service
  }
  
  func resolve<Service, Arg>(arg: Arg) -> Service {
    guard let service = resolve(Service.self, argument: arg) else {
      fatalError("Swinject.Resolver service \(Service.self) is not registered")
    }
    
    return service
  }
  
  func resolve<Service, Arg1, Arg2>(arg1: Arg1, arg2: Arg2) -> Service {
    guard let service = resolve(Service.self, arguments: arg1, arg2) else {
      fatalError("Swinject.Resolver service \(Service.self) is not registered")
    }
    
    return service
  }
  
  func resolve<Service>(type: Service.Type) -> Service {
    guard let service = resolve(type) else {
      fatalError("Swinject.Resolver service \(type) is not registered")
    }
    
    return service
  }
  
  func resolve<Service, Arg>(type: Service.Type, arg: Arg) -> Service {
    guard let service = resolve(Service.self, argument: arg) else {
      fatalError("Swinject.Resolver service \(type) is not registered")
    }
    
    return service
  }
}
