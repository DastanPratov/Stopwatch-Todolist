//
//  Alert.swift
//  S&T
//
//  Created by Dastan on 28/6/22.
//

import UIKit

struct Alert
{
    static func showBasicAlert(title: String, message: String, on vc: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Понял", style: .cancel)
        
        alert.addAction(dismiss)
        vc.present(alert, animated: true)
    }
}
