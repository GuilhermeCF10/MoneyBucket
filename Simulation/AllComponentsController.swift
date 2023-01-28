//
//  AllComponentsController.swift
//  Simulation
//
//  Created by Student on 29/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

// Chart URL API: https://quickchart.io/chart-maker/
 let baseURL: String = "https://quickchart.io/chart?width=300&height=280&c=";


// App Data
var user = UserInfo()
var app = GeneralControl()



class InvestimentosViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var valueAvailable: UILabel!
    
    @IBOutlet weak var userSalary: UILabel!
    
    @IBOutlet weak var chartImage: UIImageView!
    
    @IBOutlet weak var descInvest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let available = getAvailableValue()
        
        let addons = self.makeSimulation(available)
        
        let description = self.formatValues(available, addons)
        
        self.updateOutlets(available, description)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    func updateOutlets(_ available: Double, _ description: [String]) {
        userName.text = user.name
        userSalary.text = "R$ \(String(format: "%.2f", user.salary).replacingOccurrences(of: ".", with: ","))"
        valueAvailable.text = "R$ \(String(format: "%.2f", available).replacingOccurrences(of: ".", with: ","))"
        descInvest.text = "Ao longo de 30 anos, investindo R$\(description[0]) por mês, com uma taxa de rendimento anual de \(description[1])%, você terá acumulado R$\(description[2]), mesmo que você tenha investido apenas R$\(description[3]) durante todo o tempo, o que representa \(description[4])% do valor total acumulado."
    }
    
    func getAvailableValue() -> Double {
        var currentValue: Double = user.salary
        
        let valuesList = app.getList()
        
        valuesList.map{
            currentValue = currentValue + Double($0.price)
        }
        
        return currentValue
    }
    
    func makeSimulation(_ available: Double) -> [Double] {
    
        var valuesWhenInvesting = [available*app.investmentRate]
        let pureValue = available * 360
        
        for i in 0...360 {
            valuesWhenInvesting.append((valuesWhenInvesting[i]+available)*app.investmentRate)
        }
        
    
        let chartData = "[\(valuesWhenInvesting[0]),\(valuesWhenInvesting[60]),\(valuesWhenInvesting[120]),\(valuesWhenInvesting[180]),\(valuesWhenInvesting[240]),\(valuesWhenInvesting[300]),\(valuesWhenInvesting[360])]"
        
        
        generateChart(chartData)
        
        return [valuesWhenInvesting[360], pureValue]
    }
    
    func formatValues(_ available: Double, _ addons: [Double]) -> [String] {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "es_ES")
        nf.maximumFractionDigits = 2
        
        let values = [available, ((app.investmentRate - 1)*12)*100, addons[0], addons[1], (addons[1]/addons[0])*100]
        
        var description: [String] = []
        
        for i in 0...4 {
            description.append(nf.string(from: values[i] as NSNumber) ?? "")
        }
        
        return description
    }
        
    func generateChart(_ data: String) -> Void {
        let months = "['1', '5', '10', '15', '20', '25', '30']";
        
        let createChart = """
            {
              type: 'bar',
              data: {
                labels: \(months),
                datasets: [
                  {
                    label: 'Ano',
                    color: '#E0E1E3',
                    backgroundColor: 'rgba(52, 199, 89, 1.0)',
                    borderColor: 'rgb(128, 128, 128)',
                    borderWidth: 1,
                    data: \(data),
                  }
                ],
              },

              options: {
                legend: {
                    labels: {
                        fontColor: "#E0E1E3"
                    }
                },
                title: {
                    display: true,
                    text: 'Simulação de Investimentos',
                    fontColor: "#E0E1E3"
                },
                scales: {
                   yAxes: [{
                       ticks: {
                           fontColor: "#E0E1E3",

                       }
                   }],
                   xAxes: [{
                       ticks: {
                           fontColor: "#E0E1E3",
                       }
                   }]
               },
              },
            }
        """
    
        let createChartURL = createChart.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let chartURL = baseURL + createChartURL!
        let chart = URL(string: chartURL)!
        
        changeChart(chart)
    }
    
    func changeChart(_ url: URL) {
        if let changingChart = try? Data(contentsOf: url) {
            chartImage.image = UIImage(data: changingChart)
        }
    }
}

class ControlExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    
    @IBOutlet weak var inputCostTitle: UITextField!
    
    @IBOutlet weak var inputCostPrice: UITextField!
    
    @IBAction func expenseButton(_ sender: Any) {
        let convertInputCostPrice: Double = (inputCostPrice.text! as NSString).doubleValue
        app.addExpenses(name: String(inputCostTitle.text!), price: -convertInputCostPrice)
        self.tableView.reloadData()
        inputCostTitle.text = ""
        inputCostPrice.text = ""
    }
    
    
    

        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Keyboard Dismiss
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
 
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.getList().count // your number of cells here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "control", for: indexPath)

        if let controlCell = cell as? ControlExpensesTableViewCell {
            let control = app.getList()[indexPath.row]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            let dateUpdated = dateFormatter.string(from: control.date)
            
            controlCell.date.text = dateUpdated
            controlCell.name.text = String(control.name)
            controlCell.price.text = "R$ \(String(format: "%.2f", abs(control.price)).replacingOccurrences(of: ".", with: ","))"
            
            return controlCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            app.expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}



class ControlExpensesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
}


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var inputUserName: UITextField!
   
    @IBOutlet weak var inputUserSalary: UITextField!
    
    @IBOutlet weak var inputAnualPercentage: UITextField!
   
    @IBAction func resetButton(_ sender: Any) -> Void {
        user.changeName("")
        user.changeSalary(0.0)
        app.removeAllExpenses()
        inputUserName.text = ""
        inputUserSalary.text = ""
        
    }
    
    @IBAction func saveButton(_ sender: Any) -> Void {
        let convertedSalary = (inputUserSalary.text! as NSString).doubleValue
        user.changeName(String(inputUserName.text!))
        user.changeSalary(convertedSalary)
        inputUserName.text = ""
        inputUserSalary.text = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputAnualPercentage.text = "\(String(format: "%.2f", ((app.investmentRate - 1)*12)*100).replacingOccurrences(of: ".", with: ",")) %"
        
        // Keyboard Dismiss
       let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
