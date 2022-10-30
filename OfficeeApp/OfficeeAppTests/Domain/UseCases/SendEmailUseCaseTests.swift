//
//  SendEmailUseCaseTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import XCTest
@testable import OfficeeApp

final class SendEmailUseCaseTests: XCTest {
  func test_throwsAnErrorOnURLOpeningError_andPerformEmailSendingToReceiverOnlyOnce() {
    let recipientEmail = someEmailString
    let urlOpening = URLOpeningSpy(error: anyNSError)
    let sut = SendEmailUseCaseImpl(urlOpening: urlOpening)
    
    XCTAssertThrowsError(try sut.invoke(with: recipientEmail))
    XCTAssertEqual(urlOpening.openingURLs.count, 1)
    XCTAssert(urlOpening.openingURLs[0].absoluteString.contains(recipientEmail) == true)
  }
  
  func test_performEmailSendingToTheFirstAndSecondRecipientsWithoutError() {
    let firstRecipient  = "first.recipient@email.com"
    let secondRecipient = "second.recipient@email.com"
    let urlOpening = URLOpeningSpy(error: nil)
    let sut = SendEmailUseCaseImpl(urlOpening: urlOpening)
    
    XCTAssertNoThrow(try sut.invoke(with: firstRecipient))
    XCTAssertEqual(urlOpening.openingURLs.count, 1)
    XCTAssertNoThrow(try sut.invoke(with: secondRecipient))
    XCTAssertEqual(urlOpening.openingURLs.count, 2)
    XCTAssert(urlOpening.openingURLs[0].absoluteString.contains(firstRecipient) == true)
    XCTAssert(urlOpening.openingURLs[1].absoluteString.contains(secondRecipient) == true)
  }
}

final class URLOpeningSpy: URLOpening {
  let error: Error?
  private(set) var openingURLs = [URL]()
  
  init(error: Error?) {
    self.error = error
  }
  
  func open(url: URL) throws {
    openingURLs.append(url)
    
    guard let error = error else { return }
    
    throw error
  }
}
