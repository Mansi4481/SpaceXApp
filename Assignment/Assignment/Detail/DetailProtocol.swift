//
//  DetailProtocol.swift
//  Assignment
//
//  Created by Manshi Viramgama on 29/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: Router Protocol
/// Protocol to pass controll to its corrdinator to take navigation decisions
/// Workes as Router Protocol
protocol DetailRouting: AnyObject {
    
    // TODO: Add routing functions here
    /// Gets called when user selects continue action on the screen
}

// MARK: Presenter Protocol
/// Presenter protocol for Stack
protocol DetailPresentationInput: AnyObject {
    /// Retrieve details
    /// - Returns: detail string
    func getDetails() -> String?
}

// MARK: Interactor Protocol
/// Used to send calls and data to Interactor
protocol DetailInteractorInput: AnyObject {}

// MARK: Interactor Output Protocol
/// Used to send calls and data to Presenter
protocol DetailInteractorOutput: AnyObject {}

// MARK: ViewController Protocol
/// Used to send calls and data to UIViewController
protocol DetailUI: AnyObject {
    /// Update details
    /// - Parameter details: detail string
    func updateDetails(details: String)
}
