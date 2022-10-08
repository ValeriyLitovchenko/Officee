//
//  SwinjectServiceLocator.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Swinject

struct SwinjectServiceLocator: ServiceLocating {
  
  // MARK: - Properties
  
  private let container = Swinject.Container()
  private let assembler: Swinject.Assembler
  
  // MARK: - Constructor
  
  init() {
    assembler = Swinject.Assembler(
      [
        NetworkLayerAssembly(),
        StorageAssembly(),
        RepositoryAssembly()
      ],
      container: container)
  }
  
  // MARK: - Functions
  
  func resolve<Service>() -> Service {
    assembler.resolver.resolve()
  }
  
  func resolve<Service>(_ serviceType: Service.Type) -> Service {
    assembler.resolver.resolve()
  }
  
  func resolve<Service, Arg1>(arg: Arg1) -> Service {
    assembler.resolver.resolve(arg: arg)
  }
  
  func resolve<Service, Arg1, Arg2>(arg1: Arg1, arg2: Arg2) -> Service {
    assembler.resolver.resolve(arg1: arg1, arg2: arg2)
  }
}
