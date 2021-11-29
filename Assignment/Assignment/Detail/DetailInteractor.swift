//
//  DetailInteractor.swift
//  Assignment
//
//  Created by Manshi Viramgama on 29/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: DetailInteractor allocation and initializations
final class DetailInteractor {

    // MARK: Presenter Protocol for output from Interactor
    weak var output: DetailInteractorOutput?
}

// MARK: Confirming to DetailInteractorInput protocol
extension DetailInteractor: DetailInteractorInput {}
