import Foundation
import UIKit

// MARK: HomePresenterInput (view to presenter)
protocol HomePresenterInput: AnyObject {
    /// Load launch data with pagination
    func loadData()
    
    /// Launch data count
    /// - Returns: count
    func getLaunchDataCount() -> Int
    
    /// Launch related info
    /// - Parameter index: index to get info
    /// - Returns: info for the given index
    func getDocInfo(for index: Int) -> Doc?
    
    /// Apply filter
    func applyFilterIfApplicable()
    
    /// Selected Launch cell
    /// - Parameters:
    ///   - index: selected index
    ///   - navController: root navigation
    func selectedLaunch(for index: Int, navController: UINavigationController)
}

// MARK: HomePresenterOutput (presenter to view)
protocol HomePresenterOutput: AnyObject {
    /// Update screen when get data
    /// - Parameter filterOn: check if filter applied or not
    func updateListOfLaunches(with filterOn: Bool)
    
    /// Display error
    /// - Parameter error: error
    func handleFailure(with error: APIError)
}

// MARK: HomeInteractorInput (presenter to interactor)
protocol HomeInteractorInput: AnyObject {
    /// Get list of launches
    /// - Parameter page: page number
    func getListOfLaunches(with page: Int)
}

// MARK: HomeInteractorOutput (interactor to presenter)
protocol HomeInteractorOutput: AnyObject {
    /// Launches data fetched
    /// - Parameter launchDetail: launch detail
    func getListOfLaunchesSuccess(launchDetail: Launches)
    
    /// Failure handling
    /// - Parameter error: error
    func getListOfLaunchesFailure(error: APIError)
}

// MARK: HomeRouting (navigations)
protocol HomeRouting: AnyObject {
    /// navigate to detail screen
    /// - Parameters:
    ///   - detail: detail string
    ///   - navController: navigation to push into
    func routeToDetails(detail: String, navController: UINavigationController)
}
