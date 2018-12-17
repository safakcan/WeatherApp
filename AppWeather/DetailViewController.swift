//
//  DetailedTableViewCell.swift
//  AppWeather
//
//  Created by Can Bas on 11/20/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var detailedCellImage: UIImageView!
    @IBOutlet var detailedCellDegree: UILabel!
    @IBOutlet var detailedCellName: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var rain: UILabel!
    @IBOutlet var wind: UILabel!
    
    var weatherInCell = Weather(latitude: 0.0, longitude: 0.0)
    var tableArray: [FutureWeather]?
    var apiHelper = ApiHelper()
    var dataProvider = DataProvider(apiHandler: ApiHelperWithFramework())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.getForecastData(lat: weatherInCell.latitude, long: weatherInCell.longitude, apiCallType: ApiCallType.forecast) { (futureWeathers) in
            DispatchQueue.main.async {
                self.tableArray = futureWeathers
                self.detailTableView.reloadData()
                self.updateData()
            }
        }
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateData() {
        detailedCellName.text = weatherInCell.name
        detailedCellName.sizeToFit()
        
        if let hum = tableArray?.first?.humidity {
            humidity.text = String(hum)
            print(hum)
        }
        
        if let image = weatherInCell.image {
            detailedCellImage.image = UIImage(data: image)
        }
        if let temp = weatherInCell.temp {
            detailedCellDegree.text = String(format: "%.f",temp) + "\u{00B0}"
        }
        if let rainText = tableArray?.first?.rain {
            rain.text = "%" + String(format: "%.2f",rainText)
        }
        if let windText = tableArray?.first?.wind {
            wind.text = String(format: "%..f",windText) + "m/s"
        }
    }
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as? ForecastTableViewCell
        
        if let cellDate  = tableArray?[indexPath.row].date {
            cell?.futureDateCell?.text = String(cellDate)
        }
        if let cellImage = tableArray?[indexPath.row].image {
            cell?.futureImagaeCell.image = UIImage(data: cellImage)
        }
        if let cellDegree = tableArray?[indexPath.row].temp {
            cell?.futureTempCell.text = String(format: "%.f", cellDegree) + "\u{00B0}"
        }
        
        return cell!
    }
}
