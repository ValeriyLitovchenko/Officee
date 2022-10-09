//
//  SendEmailUseCaseImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit

struct SendEmailUseCaseImpl: SendEmailUseCase {
  func invoke(with email: String) {
    guard let mailtoString = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let mailtoUrl = URL(string: mailtoString),
             UIApplication.shared.canOpenURL(mailtoUrl)
    else { return }
    
    UIApplication.shared.open(mailtoUrl, options: [:])
  }
}
