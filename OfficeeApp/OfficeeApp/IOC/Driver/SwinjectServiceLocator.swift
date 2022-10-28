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
  
  // MARK: - Constructor
  
  init(assemblies: [Swinject.Assembly]) {
    assemblies.forEach { assembly in
      assembly.assemble(container: container)
    }
  }
  
  // MARK: - Functions
  
  func unsafeResolve<Service>() -> Service {
    container.unsafeResolve()
  }
  
  func unsafeResolve<Service>(_ serviceType: Service.Type) -> Service {
    container.unsafeResolve(serviceType)
  }
  
  func resolve<Service>() -> Service? {
    container.resolve(Service.self)
  }
  
  func resolve<Service>(_ serviceType: Service.Type) -> Service? {
    container.resolve(serviceType)
  }
}

extension SwinjectServiceLocator {
  static var serviceLocatorWithAllProjectAssemblies: SwinjectServiceLocator {
    .init(assemblies: [
      NetworkLayerAssembly(),
      StorageAssembly(),
      RepositoryAssembly(),
      UsecaseAssembly()
    ])
  }
}
