//
//  AppDelegate.swift
//  PhonePePaymentExample
//
//  Created by Vishal Jhanjhri on 17/11/21.
//

import UIKit
import PhonePePayment

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        let handled = PhonePeDPSDK.checkDeeplink(url)
        if handled {
            // Phonepe is handling this, no need for any processing
            return true
        }
        // Process your own deeplinks here
        return true
    }
}
