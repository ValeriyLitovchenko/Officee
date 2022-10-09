//
//  GetPeopleUseCase.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Officee
import Combine

protocol GetPeopleUseCase {
  func invoke(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Swift.Error>
}
