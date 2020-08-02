//
//  UIViewController+Navigation.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/08/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func toContactUs() {
        let email = "stephano.telolahy@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            openUrl(url)
        }
    }
    
    func toRules() {
        let rulesUrl = "http://www.dvgiochi.net/bang/bang_rules.pdf"
        if let url = URL(string: rulesUrl) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let safariViewController = SFSafariViewController(url: url, configuration: config)
                present(safariViewController, animated: true)
            } else {
                openUrl(url)
            }
        }
    }
    
    private func openUrl(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
