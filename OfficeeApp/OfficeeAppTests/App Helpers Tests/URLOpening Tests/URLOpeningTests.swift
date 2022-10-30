//
//  URLOpeningTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import XCTest
@testable import OfficeeApp

final class URLOpeningTests: XCTest {
  func test_throwsAnErrorWhileOpensUnavailableURL() {
    let unavailableURL = unavailableURL
    let sut = makeSUT()
    
    XCTAssertThrowsError(try sut.open(url: unavailableURL))
  }
  
  func test_notThrowsAnErrorWhileOpensOpenableURL() {
    let openableURL = appleURL
    let sut = makeSUT()
    
    XCTAssertNoThrow(try sut.open(url: openableURL))
  }
  
  private func makeSUT() -> URLOpening {
    UIApplication.shared
  }
}
