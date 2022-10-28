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
        httpClient: resolver.unsafeResolve(),
        urlRequestFactory: resolver.unsafeResolve(),
        peopleStorage: resolver.unsafeResolve())
    }
    
    container.register(RoomsFeedRepository.self) { resolver in
      RoomsFeedRepositoryImpl(
        httpClient: resolver.unsafeResolve(),
        urlRequestFactory: resolver.unsafeResolve(),
        roomsStorage: resolver.unsafeResolve())
    }
  }
}
