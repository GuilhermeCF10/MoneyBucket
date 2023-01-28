//
//  InvestimentosViewController.swift
//  Simulation
//
//  Created by Student on 19/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

//class InvestimentosViewController: UIViewController {
//    
//    @IBOutlet weak var chartImage: UIImageView!
//
//    @IBOutlet weak var userName: UILabel!
//    
//    @IBOutlet weak var userSalary: UILabel!
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        user.changeName("Guilherme Fialho")
//        user.changeSalary(26000)
//        
//        
//        userName.text = user.name
//        userSalary.text = "R$ \(String(user.salary).replacingOccurrences(of: ".", with: ","))"
//        
//        //  API: https://quickchart.io/chart-maker/
//
//    
//        let baseURL: String = "https://quickchart.io/chart?width=300&height=350&c=";
//
//        let months = "['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']";
//    
//        
//        
//        let createChart = """
//            {
//              type: 'bar',
//              data: {
//                labels: \(months),
//                datasets: [
//                  {
//                    label: '12 meses',
//                    color: '#E0E1E3',
//                    backgroundColor: 'rgba(52, 199, 89, 1.0)',
//                    borderColor: 'rgb(128, 128, 128)',
//                    borderWidth: 1,
//                    data: [500, 505, 510.5, 520, 535, 540, 550, 560, 570, 580, 590, 900],
//                  }
//                ],
//              },
//                
//              options: {
//                legend: {
//                    labels: {
//                        fontColor: "#E0E1E3"
//                    }
//                },
//                title: {
//                    display: true,
//                    text: 'Simulação de Investimentos',
//                    fontColor: "#E0E1E3"
//                },
//                scales: {
//                   yAxes: [{
//                       ticks: {
//                           fontColor: "#E0E1E3",
//                           
//                       }
//                   }],
//                   xAxes: [{
//                       ticks: {
//                           fontColor: "#E0E1E3",
//                       }
//                   }]
//               },
//              },
//            }
//        """
//        
//        let createChartURL = createChart.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        let chartURL = baseURL + createChartURL!
//
//        let testing = URL(string: chartURL)!
//
//        if let datatesting = try? Data(contentsOf: testing) {
//            chartImage.image = UIImage(data: datatesting)
//        }
//    }
//}
