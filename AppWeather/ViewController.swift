//
//  ViewController.swift
//  AppWeather
//
//  Created by Can Bas on 11/11/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBAction func showTempType(_ sender: Any) {
        isCelcius = !isCelcius
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var showDegree: UILabel!
    @IBOutlet weak var showWeatherImage: UIImageView!
    @IBOutlet weak var showCityName: UILabel!
    
    var weathers = [Weather]()
    var initialWeathers = [Weather]()
    var isCelcius:Bool = true
    var currentWeather: Weather?
    
    var filteredData = [String]()
    var isSearching = false
    
    let locationManager = CLLocationManager()
    let apiHelper = ApiHelper()
    let dataProvider = DataProvider(apiHandler: ApiHelperWithFramework())
    var counter = 0;
    
    var detailTableWeather = Weather(latitude: 0.0, longitude: 0.0)
    var forecastedWeather = Weather(latitude: 0.0, longitude: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempImageView = UIImageView(image: UIImage(named: "homeTableviewBackground"))
        tempImageView.frame = tabelView.frame
        tabelView.backgroundView = tempImageView;
        tabelView.separatorStyle = .none
        
        // Do any additional setup after loading the view, typically from a nib.
        tabelView.dataSource = self
        tabelView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: database'ten kordinatları weathers a çek
        addAllData()
        getAllData()
    }
    
    func updateCurrentWeather() {
        //TODO: set weather
        if let temp = currentWeather?.temp {
            showDegree.text =  String(format: "%.f",temp) + "\u{00B0}"
            showDegree.sizeToFit()
        }
        
        showCityName.text = currentWeather?.name
        showCityName.sizeToFit()
        showWeatherImage.image = UIImage(data: (currentWeather?.image)!)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count//weathers.count //TODO: Weathers count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell
        
        if let temp = weathers[indexPath.row].temp{
            cell?.weatherDegree.text = String(format: "%.f",temp) + "\u{00B0}"
        }
        if let image = weathers[indexPath.row].image {
            cell?.weatherIcon.image = UIImage(data: image)
        }
        cell?.weatherName.text = weathers[indexPath.row].name
        cell?.weatherName.sizeToFit()
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == UITableViewCellEditingStyle.delete {
    
            if isSearching == false {
                weathers.remove(at: indexPath.row)
                initialWeathers.remove(at: indexPath.row)
                CoreDataBase.deleteData(at: indexPath.row)
            }else{
                for index in 0...initialWeathers.count-1 {
                    if weathers[indexPath.row].name == initialWeathers[index].name{
                        CoreDataBase.deleteData(at: index)
                        initialWeathers.remove(at: index)
                        weathers.remove(at: indexPath.row)

                    }
                }
                
            }
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailTableWeather = weathers[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentWeather = Weather(latitude: locValue.latitude, longitude: locValue.longitude)
        dataProvider.getWeatherData(lat: (currentWeather?.latitude)!, lon: (currentWeather?.longitude)!, apiCallType: ApiCallType.weatherWithCelcius ) { (callbackWeather) in
            self.currentWeather = callbackWeather
            DispatchQueue.main.async {
                self.updateCurrentWeather()
            }
        }
    }
    
    func addAllData () {
        CoreDataBase.retrieveData { (array) in
            initialWeathers.append(contentsOf: array)
            print(array)
        }
        
    }
    
    func getAllData() {
        if initialWeathers.count == 0 {
            return
        }
        dataProvider.getWeatherData(lat: initialWeathers[counter].latitude, lon: initialWeathers[counter].longitude, apiCallType: ApiCallType.weatherWithCelcius) { (myWeather) in
            self.initialWeathers[self.counter] = myWeather
            if(self.counter + 1 < self.initialWeathers.count) {
                self.counter += 1
                self.getAllData()
            } else {
                self.counter = 0;
                DispatchQueue.main.async {
                    self.weathers = self.initialWeathers
                    self.tabelView.reloadData()
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailedCell = segue.destination as? DetailedTableViewCell {
            detailedCell.weatherInCell = detailTableWeather
            DispatchQueue.main.async {
                detailedCell.updateData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let keyWords = searchBar.text
        
        if keyWords?.count == 0 {
            isSearching = false
            weathers = initialWeathers
        } else {
            isSearching = true
            weathers = initialWeathers.filter { weather -> Bool in
                if let cityName = weather.name?.lowercased(), let keywords = keyWords?.lowercased() {
                    return cityName.contains(keywords)
                }
                return false
            }
        }
        
        tabelView.reloadData()
    }
}
