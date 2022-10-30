//
//  SendEmailUseCase.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

protocol SendEmailUseCase {
  func invoke(with email: String) throws
}
