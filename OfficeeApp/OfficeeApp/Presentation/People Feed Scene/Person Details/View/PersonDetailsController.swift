//
//  PersonDetailsController.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore
import Combine

final class PersonDetailsController: BaseTableViewController<PersonDetailsControllerView, PersonDetailsViewModel> {
  
  // MARK: - Properties
  
  private var cancellable: Cancellable?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: - Private Functions
  
  private func setupUI() {
    let `view` = contentView
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .compose,
      target: self,
      action: #selector(sendMessageAction))
    
    cancellable = viewModel.statePublisher
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] state in
        view.activityIndicator.setIsAnimating(state == .loading)
        
        guard case let .contentReady(content) = state,
              let self = self else { return }
        
        self.display(content: content)
      })
  }
  
  @objc
  private func sendMessageAction() {
    viewModel.sendMessageAction()
  }
}
