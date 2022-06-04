//
//  UIViewController.swift
//  Pixabay
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)

        let dismiss = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil)

        alert.addAction(dismiss)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }

        alert.setValue(NSAttributedString(string: message, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]), forKey: "attributedMessage")
    }
}
