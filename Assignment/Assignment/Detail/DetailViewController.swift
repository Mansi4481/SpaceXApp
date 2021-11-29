//
//  DetailViewController.swift
//  Assignment
//
//  Created by Manshi Viramgama on 29/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation

// MARK: DetailViewController
final class DetailViewController: UIViewController {
    
    /// Public variables
    var presenter: DetailPresentationInput?
    
    /// Private variables
    private let label = UILabel()
    
    /// Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Custom initialiser for DetailViewController which should not be used to allocate viewController
    /// - Parameter coder: System object
    required init?(coder: NSCoder) {
        // DetailViewController should not be allocated using init with coder
        fatalError("init(coder:) has not been implemented")
    }
    
    /// View life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Private functions
private extension DetailViewController {
    /// UI Setup
    func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.text = presenter?.getDetails() ?? "NA"
        view.addSubview(label)
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        view.addConstraint(verticalConstraint)

        let widthConstraint = NSLayoutConstraint(item: label,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1,
                                                 constant: self.view.bounds.width - 20)
        view.addConstraint(widthConstraint)

        view.backgroundColor = .white
    }
}

// MARK: ViewController Protocol confirmation
extension DetailViewController: DetailUI {
    /// Update details
    /// - Parameter details: detail string
    func updateDetails(details: String) {
        label.text = details
    }
}
