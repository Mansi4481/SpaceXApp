//
//  DetailPresenter.swift
//  Assignment
//
//  Created by Manshi Viramgama on 29/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: DetailPresenter allocation and initializations
final class DetailPresenter {

    /// Private variables
    private var router: DetailRouting?
    private let interactor: DetailInteractorInput
    private var details: String?
    
    /// Public variable
    weak var view: DetailUI?

    /// Initialize Presenter
    /// - Parameters:
    ///   - interactor  : Interactor protocol
    ///   - wireframe    : Router protocol
    ///   - details    : detail string
    init(interactor: DetailInteractorInput,
         router: DetailRouting?,
         details: String?) {
        self.interactor = interactor
        self.router = router
        self.details = details
    }
}

// MARK: Confirming to Presenter Protocol
extension DetailPresenter: DetailPresentationInput {
    
    /// Retrieve details
    /// - Returns: detail string
    func getDetails() -> String? {
        if !(details?.isEmpty ?? false) {
            return details
        }
        return nil
    }
}

// MARK: Confirming to output protocol from Interactor
extension DetailPresenter: DetailInteractorOutput {}
