//
//  UsecaseAssembly.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Swinject

struct UsecaseAssembly: Swinject.Assembly {
  func assemble(container: Container) {
    container.register(LoadFeedsUseCase.self) { resolver in
      LoadFeedsUseCaseImpl(
        peopleRepository: resolver.resolve(),
        roomsRepository: resolver.resolve())
    }
  }
}
