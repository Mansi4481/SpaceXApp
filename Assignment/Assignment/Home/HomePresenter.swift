import Foundation
import UIKit

// MARK: HomePresenter
class HomePresenter {
    /// Public variables
    let interactor: HomeInteractorInput
    let router: HomeRouting
    let view: HomePresenterOutput
    
    /// Private variables
    private var launchDetail: Launches?
    private var docs = [Doc]()
    private var allDocs = [Doc]()
    private var filterOn = false
    
    /// Initializers
    init(
        interactor: HomeInteractorInput,
        view: HomePresenterOutput,
        router: HomeRouting
    ) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
}

// MARK: HomePresenterInput Methods
extension HomePresenter: HomePresenterInput {
    /// Load launch data with pagination
    func loadData() {
        var page = 1
        if let launch = launchDetail {
            page = launch.nextPage ?? .zero
        }
        if page != .zero {
            interactor.getListOfLaunches(with: page)
        }
    }
    
    /// Launch data count
    /// - Returns: count
    func getLaunchDataCount() -> Int {
        if let launchDetails = launchDetail {
            if launchDetails.page < launchDetails.totalPages {
                return docs.count + 1
            }
            return docs.count
        }
        return .zero
    }

    /// Launch related info
    /// - Parameter index: index to get info
    /// - Returns: info for the given index
    func getDocInfo(for index: Int) -> Doc? {
        if docs.indices.contains(index) {
            return docs[index]
        }
        return nil
    }
    
    /// Apply filter
    func applyFilterIfApplicable() {
        filterOn = !filterOn
        if filterOn {
            docs = allDocs.filter({ $0.success ?? false })
        } else {
            docs = allDocs
        }
        view.updateListOfLaunches(with: filterOn)
    }
    
    /// Selected Launch cell
    /// - Parameters:
    ///   - index: selected index
    ///   - navController: root navigation
    func selectedLaunch(for index: Int, navController: UINavigationController) {
        if docs.indices.contains(index) {
            let detail = docs[index].details ?? String()
            router.routeToDetails(detail: detail, navController: navController)
        }
    }
}

// MARK: HomeInteractorOutput Methods
extension HomePresenter: HomeInteractorOutput {
    
    /// Launches data fetched
    /// - Parameter launchDetail: launch detail
    func getListOfLaunchesSuccess(launchDetail: Launches) {
        self.launchDetail = launchDetail
        allDocs.append(contentsOf: launchDetail.docs)
        if filterOn {
            docs = allDocs.filter({ $0.success ?? false })
        } else {
            docs = allDocs
        }
        view.updateListOfLaunches(with: filterOn)
    }
    
    /// Failure handling
    /// - Parameter error: error
    func getListOfLaunchesFailure(error: APIError) {
        view.handleFailure(with: error)
        
    }
}
