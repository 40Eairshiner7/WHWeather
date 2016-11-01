//
//  forcastData.swift
//  WHWeather
//
//  Created by airshiner on 10/18/16.
//  Copyright © 2016 airshiner. All rights reserved.
//
import UIKit
import Alamofire

class forcastData {
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp : String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp : String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as?  Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                let kelvinToCelsius = 1.0*(1.0 * min - 273.0)
                self._lowTemp = "\(kelvinToCelsius)"
                print(self._lowTemp)
            }
            
            if let max = temp["max"] as? Double {
                let kelvinToCelsius = 1.0*(1.0 * max - 273.0)
                self._highTemp = "\(kelvinToCelsius)"
                print(self._highTemp)
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                print(self._weatherType)
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
            print(self._date)
        }
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
