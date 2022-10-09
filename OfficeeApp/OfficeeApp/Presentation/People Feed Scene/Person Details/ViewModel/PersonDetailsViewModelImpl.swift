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
  
  private enum Constants {
    static let mainSectionIdentifier = "main_section"
  }
  
  // MARK: - Properties
  
  var statePublisher: ValuePublisher<PersonDetailsViewModelState> {
    stateSubject.eraseToAnyPublisher()
  }
  private let stateSubject = ValueSubject<PersonDetailsViewModelState>(.initial)
  
  private let person: Person
  private let sendEmailUseCase: SendEmailUseCase
  
  // MARK: - Constructor
  
  init(
    inputModel: PersonDetailsInput,
    sendEmailUseCase: SendEmailUseCase
  ) {
    self.person = inputModel.person
    self.sendEmailUseCase = sendEmailUseCase
    loadData()
  }
  
  // MARK: - Functions
  
  func loadData() {
    let content = buildContent(with: person)
    stateSubject.send(.contentReady(content))
  }
  
  func sendMessageAction() {
    sendEmailUseCase.invoke(with: person.email)
  }
  
  // MARK: - Private Functions
  
  private func buildContent(with person: Person) -> TableSections {
    let spacing = 20.0
    let attributesSpacing = 5.0
    let items = [
      PersonDetailsAvatarCellModel(avatar: person.avatar),
      PersonDetailsTitleCellModel(title: person.fullName),
      PersonDetailsSubtitleCellModel(title: person.jobTitle),
      SpacingCellModel(height: spacing),
      PersonDetailsAttributeCellModel(
        name: NSLocalizedString("Email:", comment: ""),
        value: person.email),
      SpacingCellModel(height: attributesSpacing),
      PersonDetailsAttributeCellModel(
        name: NSLocalizedString("Favourite color:", comment: ""),
        value: person.favoriteColor)
    ]
    
    return [
      TableSectionModel(
        identifier: PersonDetailsViewModelImpl.Constants.mainSectionIdentifier,
        items: items)
    ]
  }
}
