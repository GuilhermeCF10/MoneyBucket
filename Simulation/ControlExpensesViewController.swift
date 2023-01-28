//
//  ControlExpensesViewController.swift
//  Simulation
//
//  Created by Student on 24/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

//class ControlExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var appDataInformation = AppData()
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        
//        appDataInformation.app.addExpenses(name: "Shopping", price: 3000.5)
//        appDataInformation.app.addExpenses(name: "Luz", price: 150)
//        appDataInformation.app.addExpenses(name: "Internet", price: 100)
//        appDataInformation.app.addExpenses(name: "Alimentação", price: 600.7)
//        appDataInformation.app.addExpenses(name: "Shopping", price: 3000.35)
//        appDataInformation.app.addExpenses(name: "Luz", price: 150)
//        appDataInformation.app.addExpenses(name: "Internet", price: 100)
//        appDataInformation.app.addExpenses(name: "Alimentação", price: 600)
//        appDataInformation.app.addExpenses(name: "Shopping", price: 3000)
//        appDataInformation.app.addExpenses(name: "Luz", price: 150)
//        appDataInformation.app.addExpenses(name: "Internet", price: 100)
//        appDataInformation.app.addExpenses(name: "Alimentação", price: 600)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return appDataInformation.app.getList().count // your number of cells here
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "control", for: indexPath)
//
//        if let controlCell = cell as? ControlExpensesTableViewCell {
//            let control = appDataInformation.app.getList()[indexPath.row]
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/YY"
//            let dateUpdated = dateFormatter.string(from: control.date)
//            
//            controlCell.date.text = dateUpdated
//            controlCell.name.text = String(control.name)
//            controlCell.price.text = "R$ \(String(format: "%.2f", control.price).replacingOccurrences(of: ".", with: ","))"
//            
//            return controlCell
//        }
//        return cell
//    }
//}
