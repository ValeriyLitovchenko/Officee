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
  
  var isLoading: ValuePublisher<Bool> {
    isLoadingSubject.eraseToAnyPublisher()
  }
  private let isLoadingSubject = ValueSubject<Bool>(false)
  
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
      .handleEvents(receiveSubscription: { [weak self] _ in
        self?.isLoadingSubject.send(true)
      })
      .sink(receiveCompletion: { [weak self] _ in
        guard let self = self else { return }
        
        self.isLoadingSubject.send(false)
        self.navigationActions.openTabBar()
      }, receiveValue: { _ in })
  }
}
