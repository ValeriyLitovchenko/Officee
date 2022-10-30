//
//  SharedTestHelpers.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Foundation

// swiftlint:disable force_unwrapping

var unavailableURL: URL {
  URL(string: "unavailable-url://cant.open.this")!
}

var appleURL: URL {
  URL(string: "https://apple.com")!
}

var anyNSError: Error {
  NSError(domain: "any error", code: .zero)
}

var someEmailString: String {
  "someemail@email.com"
}
