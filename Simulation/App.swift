//
//  App.swift
//  Simulation
//
//  Created by Student on 25/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import Foundation

struct Control {
    var date: Date
    var name: String
    var price: Double
}

struct UserInfo {
    var name: String = ""
    var salary: Double = 0
    
    mutating func changeName(_ name: String) -> Void {
        self.name = name
    }
    
    mutating func changeSalary(_ salary: Double) -> Void {
        self.salary = salary
    }
}

struct GeneralControl {
    var expenses: [Control] = []
    var investmentRate: Double = 1 + (0.10/12)
    
    
    mutating func addExpenses(name: String, price: Double) -> Void {
        self.expenses.append(Control(date: Date(), name: name, price: price))
    }
    
    mutating func removeExpenses(index: Int) -> Void {
        self.expenses.remove(at: index)
    }
    
    mutating func removeAllExpenses() -> Void {
        self.expenses = []
    }
    
    func getList() -> [Control] {
        var controller = expenses
        // Order By Date
        controller.sort{
            $0.date > $1.date
        }
        
        
        return controller
    }
}
