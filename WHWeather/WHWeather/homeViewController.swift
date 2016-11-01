//
//  homeViewController.swift
//  WHWeather
//
//  Created by airshiner on 10/12/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var pullOutMenu: UIPanGestureRecognizer!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var forcastTable: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var inputCityName : String!
    
    var curWeather: currentWeather!
    var forcasts = [forcastData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        
        forcastTable.delegate = self
        forcastTable.dataSource = self
        curWeather = currentWeather()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationModel()
    }
    
    func locationModel() {
        currentLocation = locationManager.location
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        print("latitude \(Location.sharedInstance.latitude)")
        print("longitude \(Location.sharedInstance.longitude))")
        curWeather.downloadWeatherDetailsByLocation{
            self.downloadForecastDataByLocation {
                self.updateUI()
            }
        }
    }
    
    func cityModel() {
        curWeather.downloadWeatherDetailsByCity {
            self.downloadForecastDataByCity {
                self.updateUI()
            }
        }
    }
    
    func downloadForecastDataByCity(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL_BY_CITY_NAME)!
        Alamofire.request(forecastURL).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? Array<Dictionary<String, AnyObject>> {
                    for x in list {
                        let forecast = forcastData(weatherDict: x)
                        self.forcasts.append(forecast)
                    }
                    self.forcastTable.reloadData()
                }
            }
            completed()
        }
        self.forcasts.removeAll()
    }
    
    func downloadForecastDataByLocation(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL_BY_LOCATION)!
        Alamofire.request(forecastURL).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? Array<Dictionary<String, AnyObject>> {
                    for x in list {
                        let forecast = forcastData(weatherDict: x)
                        self.forcasts.append(forecast)
                    }
                    self.forcastTable.reloadData()
                }
            }
            completed()
        }
        self.forcasts.removeAll()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForcastCell", for: indexPath) as? forcastCell {
            let forcast = forcasts[indexPath.row]
            cell.configureCell(forcast: forcast)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func updateUI() {
        tempLabel.text = "\(curWeather.temperature)"
        descriptionLabel.text = curWeather.weatherType
        cityLabel.text = curWeather.cityName
        weatherImage.image = UIImage( named:curWeather.weatherType )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func showCityModel() {
        cityModel()
        self.forcasts.removeAll()
    }
    
    public func showLocationModel() {
        locationModel()
        self.forcasts.removeAll()
    }
}
