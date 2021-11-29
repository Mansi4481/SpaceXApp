import UIKit

// MARK: HomeRouter
final class HomeRouter {
    /// Builder
    /// - Parameter navController: navigation
    /// - Returns: viewcontroller
    func buildModule(navController: UINavigationController) -> UIViewController {
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(
            interactor: interactor,
            view: viewController,
            router: self
        )
        viewController.presenter = presenter
        interactor.presenter = presenter
        navController.pushViewController(viewController, animated: true)
        return navController
    }
}

// MARK: HomeRouting methods
extension HomeRouter: HomeRouting {
    /// navigate to detail screen
    /// - Parameters:
    ///   - detail: detail string
    ///   - navController: navigation to push into
    func routeToDetails(detail: String, navController: UINavigationController) {
        let details = DetailRouter().buildModule(details: detail)
        navController.pushViewController(details, animated: true)
    }
}
