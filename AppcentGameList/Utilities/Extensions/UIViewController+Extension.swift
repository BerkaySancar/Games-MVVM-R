//
//  UIViewController+Extension.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 8.03.2023.
//

import Foundation
import UIKit.UIViewController

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
