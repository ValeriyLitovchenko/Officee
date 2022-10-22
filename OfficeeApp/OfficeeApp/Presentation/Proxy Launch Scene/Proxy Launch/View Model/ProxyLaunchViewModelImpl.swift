//
//  ProxyLaunchViewModelImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import Combine

final class ProxyLaunchViewModelImpl: ProxyLaunchViewModel {
  
  // MARK: - Properties
  
  var statePublisher: ValuePublisher<ProxyLaunchViewModelState> {
    stateSubject.eraseToAnyPublisher()
  }
  private let stateSubject = ValueSubject<ProxyLaunchViewModelState>(.initial)
  
  private let loadFeedsUseCase: LoadFeedsUseCase
  private let navigationActions: ProxyLaunchNavigationActions
  private var cancelable: Cancellable?
  
  // MARK: - Constructor
  
  init(
    loadFeedsUseCase: LoadFeedsUseCase,
    navigationActions: ProxyLaunchNavigationActions
  ) {
    self.loadFeedsUseCase = loadFeedsUseCase
    self.navigationActions = navigationActions
  }
  
  // MARK: - Functions
  
  func loadData() {
    cancelable = loadFeedsUseCase.invoke()
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
      .add(operationStatePublisher: stateSubject.statePublisher)
      .sink(receiveCompletion: { [weak self] result in
        guard let self = self else { return }
        
        if case let .failure(error) = result {
          self.navigationActions.showToastMessage(error.localizedDescription)
        }
        self.navigationActions.openTabBar()
      }, receiveValue: { _ in })
  }
}
