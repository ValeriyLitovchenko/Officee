//
//  ProxyLaunchController.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import OfficeeiOSCore
import Combine

final class ProxyLaunchController: BaseViewController<ProxyLaunchControllerView, ProxyLaunchViewModel> {
  
  // MARK: - Properties
  
  private var cancellable: Cancellable?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.loadData()
  }
  
  // MARK: - Private Fucntions
  
  private func setupUI() {
    let `view` = contentView
    
    cancellable = viewModel.statePublisher
      .dispatchOnMainQueue()
      .sink { state in
        state == .loading ?
          view.activityIndicator.startAnimating() :
          view.activityIndicator.stopAnimating()
      }
  }
}
