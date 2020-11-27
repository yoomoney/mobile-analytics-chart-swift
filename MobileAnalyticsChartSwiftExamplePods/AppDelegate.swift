import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let listChartsModule = ListChartsAssembly.makeModule()
        let rootViewController = UINavigationController(
            rootViewController: listChartsModule
        )
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        return true
    }
}
