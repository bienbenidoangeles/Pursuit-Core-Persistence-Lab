//
//  ShowAlertController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/21/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
extension UIViewController{
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
