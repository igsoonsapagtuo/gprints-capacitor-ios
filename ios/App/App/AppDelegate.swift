import UIKit
import Capacitor

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Called when the app was launched with a url. Feel free to add additional processing here,
        // but if you want the App API to support tracking app url opens, make sure to keep this call
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Called when the app was launched with an activity, including Universal Links.
        // Feel free to add additional processing here, but if you want the App API to support
        // tracking app url opens, make sure to keep this call
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let url = userActivity.webpageURL,
           let page = AppDelegate.inAppPage(for: url) {
            openInWebView(page)
        }
        return ApplicationDelegateProxy.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    // The site hands the app only its app-handoff namespace,
    // https://app.gratefulprintsph.com/open/<page> (server/appLinks.ts), and
    // only for flows that began in the app, such as a payment return. The
    // page is on the live site this app wraps (server.url in
    // capacitor.config.json), so the app shows the same URL without the /open
    // prefix. Only the app's own host is claimed (App.entitlements); anything
    // else is left alone.
    static func inAppPage(for url: URL) -> URL? {
        guard url.scheme == "https", url.host == "app.gratefulprintsph.com",
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        let prefix = "/open"
        let path = components.path
        if path == prefix || path.hasPrefix(prefix + "/") {
            let page = String(path.dropFirst(prefix.count))
            components.path = (page.isEmpty || page == "/" || page.hasPrefix("//")) ? "/home" : page
        }
        return components.url
    }

    // Loads the linked page in the Capacitor web view. On a cold start the
    // bridge view controller may not have loaded its view yet; once it has,
    // its initial load of the start URL is already under way and this load
    // replaces it, so the user lands on the linked page, not on Home.
    private func openInWebView(_ url: URL, attempt: Int = 0) {
        if let bridgeViewController = window?.rootViewController as? CAPBridgeViewController,
           bridgeViewController.isViewLoaded,
           let webView = bridgeViewController.webView {
            webView.load(URLRequest(url: url))
            return
        }
        guard attempt < 20 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.openInWebView(url, attempt: attempt + 1)
        }
    }

}
