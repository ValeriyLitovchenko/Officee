//
//  AssembliesTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 28.10.2022.
//

import XCTest
import Officee
@testable import OfficeeApp
import Swinject

final class AssembliesTests: XCTestCase {
  func test_NetworkLayerAssemblyRegisterAllRequiredDependenciesWithContainer() {
    let container = Swinject.Container()
    let sut = NetworkLayerAssembly()
    
    sut.assemble(container: container)
    
    XCTAssertNotNil(container.resolve(HTTPClient.self))
    XCTAssertNotNil(container.resolve(URLRequestFactory.self))
  }
  
  func test_StorageAssemblyRegisterAllRequiredDependenciesWithContainer() {
    let container = Swinject.Container()
    let sut = StorageAssembly()
    
    sut.assemble(container: container)
    
    XCTAssertNotNil(container.resolve(PeopleFeedStorage.self))
    XCTAssertNotNil(container.resolve(RoomsFeedStorage.self))
  }
  
  func test_RepositoryAssemblyRegisterAllRequiredDependenciesWithContainer() {
    let container = containerWithDependenciesForRepositoryAssembly()
    let sut = RepositoryAssembly()
    
    sut.assemble(container: container)
    
    XCTAssertNotNil(container.resolve(PeopleFeedRepository.self))
    XCTAssertNotNil(container.resolve(RoomsFeedRepository.self))
  }
  
  func test_UsecasesAssemblyRegisterAllRequiredDependenciesWithContainer() {
    let container = containerWithDependenciesForUsecasesAssembly()
    let sut = UsecaseAssembly()
    
    sut.assemble(container: container)
    
    XCTAssertNotNil(container.resolve(LoadFeedsUseCase.self))
    XCTAssertNotNil(container.resolve(GetPeopleUseCase.self))
    XCTAssertNotNil(container.resolve(GetRoomsUseCase.self))
    XCTAssertNotNil(container.resolve(SendEmailUseCase.self))
  }
  
  // MARK: - Helpers
  
  private func containerWithDependenciesForUsecasesAssembly() -> Swinject.Container {
    containerWith(assemblies: [
      NetworkLayerAssembly(),
      StorageAssembly(),
      RepositoryAssembly()
    ])
  }
  
  private func containerWithDependenciesForRepositoryAssembly() -> Swinject.Container {
    containerWith(assemblies: [
      NetworkLayerAssembly(),
      StorageAssembly()
    ])
  }
  
  private func containerWith(assemblies: [Swinject.Assembly]) -> Swinject.Container {
    let container = Swinject.Container()
    assemblies.forEach { assembly in
      assembly.assemble(container: container)
    }
    return container
  }
}
