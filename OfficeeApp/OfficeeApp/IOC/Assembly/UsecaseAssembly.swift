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
        peopleRepository: resolver.unsafeResolve(),
        roomsRepository: resolver.unsafeResolve())
    }
    
    container.register(GetPeopleUseCase.self) { resolver in
      GetPeopleUseCaseImpl(repository: resolver.unsafeResolve())
    }
    
    container.register(GetRoomsUseCase.self) { resolver in
      GetRoomsUseCaseImpl(repository: resolver.unsafeResolve())
    }
    
    container.register(SendEmailUseCase.self) { _ in
      SendEmailUseCaseImpl()
    }
  }
}
