//
//  LoadFeedsUseCase.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Combine

protocol LoadFeedsUseCase {
  func invoke() -> AnyPublisher<Void, Error>
}
