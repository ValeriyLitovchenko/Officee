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
  func test_returnNilOnResolveForEmptyAssemblyList() {
    let sut = SwinjectServiceLocator(assemblies: [])
    
    XCTAssertNil(sut.resolve(DummyService.self))
  }
  
  func test_registersDummyServiceForDummyServiceAssemblySpyOnlyOnce() {
    let dummyService = DumyServiceAssemblySpy()
    let sut = SwinjectServiceLocator(assemblies: [dummyService])
    
    XCTAssertNotNil(sut.resolve(DummyService.self))
    XCTAssertEqual(dummyService.assembleMethodCallingCount, 1)
  }
}

final class DumyServiceAssemblySpy: Swinject.Assembly {
  private(set) var assembleMethodCallingCount = 0
  
  func assemble(container: Container) {
    container.register(DummyService.self) { _ in
      DummyService()
    }
    
    assembleMethodCallingCount += 1
  }
}

struct DummyService {}
