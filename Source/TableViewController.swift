//
//  ViewController.swift
//  AutocompleteTextField
//
//  Created by Jeffrey Kereakoglow on 12/22/15.
//  Copyright © 2015 Alexis Digital. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

  @IBOutlet weak var nameField: AutocompleteTextField?
  @IBOutlet weak var emailField: AutocompleteTextField?

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let name = nameField, let email = emailField else {
      assertionFailure("Name field is nil. Did you forget to wire it up in Storyboard Builder?")
      return
    }

    name.autoCompleteDataSource = DataSource()
    name.autoCompleteDelegate = self
    name.suggestionLabelPosition = CGPointMake(0, -0.5)
  }
}

// MARK: - UITextFieldDelegate
extension TableViewController: UITextFieldDelegate {
  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    return true
  }

  // Dismiss the keyboard when the user hits the return key
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()

    return true
  }
}

extension TableViewController: AutocompleteDelegate {
  func textfield(textfield: AutocompleteTextField, didAcceptSuggestion suggestion: String) {

    let dataSource = DataSource()

    if let rawText = dataSource.rawTextForSuggestion(suggestion) {
      textfield.text = rawText
    }
  }
}
