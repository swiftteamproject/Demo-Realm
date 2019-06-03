//
//  ViewController.swift
//  test
//
//  Created by Анна Чаховская on 01/06/2019.
//  Copyright © 2019 Анна Чаховская. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    var dataObject: Results<Sections>!
    let tableView = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        dataObject = realm.objects(Sections.self)
        
        
        // 
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("+", comment: ""), style: .plain, target: self, action: #selector(AddNewElementObjects))
        
    }
    
    @objc func AddNewElementObjects() {
        AlertController.addAlert(in: self) { (nameSections, name, secondName) in
            
            let newObject = Sections()
            newObject.name = nameSections
            
            let newRowData = Rows()
            newRowData.name = name
            newRowData.secondName = secondName
            newObject.rows.append(newRowData)
            
            RealmService.shared.create(newObject)
            
            self.tableView.reloadData()
           
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataObject.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataObject[section].name
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataObject[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let textLabel = "\(dataObject[indexPath.section].rows[indexPath.row].name) \(dataObject[indexPath.section].rows[indexPath.row].secondName)"
        cell.textLabel?.text = textLabel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let deleteObject = dataObject[indexPath.section]
        RealmService.shared.delete(deleteObject)
        tableView.reloadData()
    }
}
