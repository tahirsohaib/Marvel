//
//  UIView-Ext.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import NVActivityIndicatorView
import UIKit
struct UIViewExtensionTags {
    static let NVActivityIndicator: Int = 1000
}

extension UIView {
    func showHUD() {
        if viewWithTag(UIViewExtensionTags.NVActivityIndicator) != nil {
            return
        }
        let activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x: frame.width / 2, y: frame.height / 2,
                          width: 40,
                          height: 40),
            type: nil, color: nil
        )
        activityIndicatorView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        activityIndicatorView.tag = UIViewExtensionTags.NVActivityIndicator
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
    }

    func hideHUD() {
        if let activityIndicator = viewWithTag(UIViewExtensionTags.NVActivityIndicator) as? NVActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
