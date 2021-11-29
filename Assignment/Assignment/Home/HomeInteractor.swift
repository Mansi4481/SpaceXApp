import Foundation

// MARK: HomeInteractor
class HomeInteractor {
    var presenter: HomeInteractorOutput?
    let repository: LaunchRepository = LaunchRepositoryImpl()
}

// MARK: HomeInteractorInput methods
extension HomeInteractor: HomeInteractorInput {
    /// Get list of launches
    /// - Parameter page: page number
    func getListOfLaunches(with page: Int) {
        repository.loadData(page: page) { (launches, error)  in
            if let launches = launches {
                self.presenter?.getListOfLaunchesSuccess(launchDetail: launches)
            } else {
                if let error = error {
                    self.presenter?.getListOfLaunchesFailure(error: error)
                }
            }
        }
    }
}
