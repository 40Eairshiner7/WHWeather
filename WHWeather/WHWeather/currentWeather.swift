//
//  currentWeather.swift
//  WHWeather
//
//  Created by airshiner on 10/18/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import Foundation
import Alamofire

class currentWeather {
    
    var _cityName : String!
    var _date: String!
    var _weatherType: String!
    var _temperature : Double!
    
    var cityName : String {
        if _cityName == nil {
            _cityName = "London"
        }
        return _cityName
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = "Sunny"
        }
        return _weatherType
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var temperature : Double {
        if _temperature == nil {
            _temperature = 0
        }
        return _temperature
    }
    
    func downloadWeatherDetailsByCity(completed: @escaping DownloadComplete) {
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL_BY_CITY_NAME)!
        Alamofire.request(currentWeatherURL) .responseJSON { (response) in
            let result = response.result
//            print(result)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
//                    print(self.cityName)
                }
                if let weather = dict["weather"] as? Array<Dictionary<String, AnyObject>> {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
//                        print(self.weatherType)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToCelsius = 1.0*(1.0 * currentTemperature - 273.0)
                        self._temperature = kelvinToCelsius
//                        print(self.temperature)
                    }
                }
            }
            completed()
        }
    }
    
    func downloadWeatherDetailsByLocation(completed: @escaping DownloadComplete) {
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL_BY_LOCATION)!
        Alamofire.request(currentWeatherURL) .responseJSON { (response) in
            let result = response.result
//            print(result)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
//                    print(self.cityName)
                }
                if let weather = dict["weather"] as? Array<Dictionary<String, AnyObject>> {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
//                        print(self.weatherType)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToCelsius = 1.0*(1.0 * currentTemperature - 273.0)
                        self._temperature = kelvinToCelsius
//                        print(self.temperature)
                    }
                }
            }
            completed()
        }
    }
    
}
