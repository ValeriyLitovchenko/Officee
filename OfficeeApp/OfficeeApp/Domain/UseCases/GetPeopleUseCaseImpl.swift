//
//  GetPeopleUseCaseImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Officee
import Combine

struct GetPeopleUseCaseImpl: GetPeopleUseCase {
  let repository: PeopleFeedRepository
  
  func invoke(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Error> {
    repository.getPeople(with: request)
  }
}
