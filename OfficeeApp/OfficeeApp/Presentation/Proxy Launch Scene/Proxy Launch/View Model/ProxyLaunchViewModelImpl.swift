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
  private var cancelable: Cancellable?
  
  // MARK: - Constructor
  
  init(loadFeedsUseCase: LoadFeedsUseCase) {
    self.loadFeedsUseCase = loadFeedsUseCase
  }
  
  // MARK: - Functions
  
  func loadData() {
    cancelable = loadFeedsUseCase.invoke()
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveSubscription: { [weak self] _ in
        self?.isLoadingSubject.send(true)
      })
      .sink(receiveCompletion: { [weak self] _ in
        self?.isLoadingSubject.send(false)
      }, receiveValue: { _ in })
  }
}
