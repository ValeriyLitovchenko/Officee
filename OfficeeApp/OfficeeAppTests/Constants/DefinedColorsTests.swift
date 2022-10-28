//
//  DefinedColorsTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 28.10.2022.
//

import XCTest
@testable import OfficeeApp

final class DefinedColorsTests: XCTestCase {
  func test_ColorResourceReturnNilForUnregisteredColorInTestsBundle() {
    let testsBundle = testsBundle
    let unregisteredColor = "unregistered_color"
    let sut = ColorResource(name: unregisteredColor, bundle: testsBundle)
    
    let resultColor = sut.color
    
    XCTAssertNil(resultColor)
  }
  
  func test_ColorResourceReturnValidColorForExistingTestColorAssetInTestsBundle() {
    let testsBundle = testsBundle
    let testColorName = "test_color"
    let expectingColor = UIColor(named: testColorName, in: testsBundle, compatibleWith: nil)
    let sut = ColorResource(name: testColorName, bundle: testsBundle)
    
    let resultColor = sut.color
    
    XCTAssertEqual(sut.name, testColorName)
    XCTAssertEqual(sut.bundle, testsBundle)
    XCTAssertEqual(resultColor, expectingColor)
  }
  
  func test_DefinedColors_thatColorsForDefinedColorResourcesExistInColorsAssetCatalog() {
    [
      DefinedColors.guardsmanRed,
      DefinedColors.avatarBorder,
      DefinedColors.flushMahogany,
      DefinedColors.activityIndicator,
      
      DefinedColors.ToastView.background,
      DefinedColors.ToastView.foreground
    ].forEach { colorResource in
      XCTAssertNotNil(colorResource.color)
    }
  }
  
  // MARK: - Helpers
  
  private var testsBundle: Bundle {
    Bundle(for: DefinedColorsTests.self)
  }
}
