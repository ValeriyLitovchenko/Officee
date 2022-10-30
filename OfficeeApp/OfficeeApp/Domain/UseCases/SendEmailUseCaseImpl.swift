//
//  SendEmailUseCaseImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

struct SendEmailUseCaseImpl: SendEmailUseCase {
  enum Error: LocalizedError {
    case emailAppUnavailable
    
    var errorDescription: String? {
      NSLocalizedString("Email application unvailable.", comment: "")
    }
  }
  
  let urlOpening: URLOpening
  
  func invoke(with email: String) throws {
    guard let mailtoString = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let mailtoUrl = URL(string: mailtoString)
    else {
      throw SendEmailUseCaseImpl.Error.emailAppUnavailable
    }
    
    do {
      try urlOpening.open(url: mailtoUrl)
    } catch {
      throw error
    }
  }
}
