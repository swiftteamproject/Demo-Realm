//
//  AlertController.swift
//  test
//
//  Created by Анна Чаховская on 02/06/2019.
//  Copyright © 2019 Анна Чаховская. All rights reserved.
//

import UIKit

class AlertController {
    public init() {}
    
    
    static func addAlert(in vc: UIViewController, completion: @escaping (String, String, String) -> Void) {
        let alert = UIAlertController(title: "Add element", message: "", preferredStyle: .alert)
        alert.addTextField { (nameSections) in
            nameSections.placeholder = "nameSections"
        }
        alert.addTextField { (name) in
            name.placeholder = "name"
        }
        alert.addTextField { (secondName) in
            secondName.placeholder = "secondName"
        }
        let action = UIAlertAction(title: "save to realm", style: .default) { (_) in
            guard let nameSections = alert.textFields?.first?.text,
                let name = alert.textFields?[1].text,
                let secondName = alert.textFields?.last?.text
                else  { return }
            completion(nameSections, name, secondName)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
