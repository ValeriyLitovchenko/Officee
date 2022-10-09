//
//  PersonDetailsViewModelImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation
import Officee
import OfficeeiOSCore

final class PersonDetailsViewModelImpl: PersonDetailsViewModel {
  
  // MARK: - Properties
  
  let sceneTitle: String
  
  var statePublisher: ValuePublisher<PersonDetailsViewModelState> {
    stateSubject.eraseToAnyPublisher()
  }
  private let stateSubject = ValueSubject<PersonDetailsViewModelState>(.initial)
  
  private let person: Person
  
  // MARK: - Constructor
  
  init(inputModel: PersonDetailsInput) {
    sceneTitle = inputModel.person.fullName
    self.person = inputModel.person
  }
  
  // MARK: - Functions
  
  func loadData() {
    
  }
}
