//
//  RepositoryAssembly.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import Swinject

struct RepositoryAssembly: Swinject.Assembly {
  func assemble(container: Container) {
    container.register(PeopleFeedRepository.self) { resolver in
      PeopleFeedRepositoryImpl(
        httpClient: resolver.resolve(),
        urlRequestFactory: resolver.resolve(),
        peopleStorage: resolver.resolve())
    }
    
    container.register(RoomsFeedRepository.self) { resolver in
      RoomsFeedRepositoryImpl(
        httpClient: resolver.resolve(),
        urlRequestFactory: resolver.resolve(),
        roomsStorage: resolver.resolve())
    }
  }
}
