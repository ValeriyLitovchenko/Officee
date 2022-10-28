//
//  ServiceLocatorTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 28.10.2022.
//

import XCTest
@testable import OfficeeApp
import Swinject

final class ServiceLocatorTests: XCTestCase {
  func test_ServiceLocatorWithEmptyAssemblyListReturnNilOnResolve() {
    let sut = SwinjectServiceLocator(assemblies: [])
    
    XCTAssertNil(sut.resolve(DummyService.self))
  }
  
  func test_ServiceLocatorRegistersDummyServiceForDumyServiceAssemblySpy() {
    let dummyService = DumyServiceAssemblySpy()
    let sut = SwinjectServiceLocator(assemblies: [dummyService])
    
    XCTAssert(dummyService.isAssembleMethodCalled)
    XCTAssertNotNil(sut.resolve(DummyService.self))
  }
}

final class DumyServiceAssemblySpy: Swinject.Assembly {
  private(set) var isAssembleMethodCalled = false
  
  func assemble(container: Container) {
    container.register(DummyService.self) { _ in
      DummyService()
    }
    
    isAssembleMethodCalled = true
  }
}

struct DummyService {}
