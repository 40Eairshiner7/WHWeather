//
//  contactsData.swift
//  WHWeather
//
//  Created by airshiner on 10/18/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let API_ID = "&appid="
let WH_KEY = "1033d270e737e0926663813bd3b4fd7b"

let WEATHER = "weather?"
let DAILY_FORECAST = "forecast/daily?"

let BY_CITY_NAME = "q="
let LON = "&lon="
let LAT = "lat="

var CITY_NAME = "London"
let COUNT = "&cnt="
let DAYS_COUNT = 5
let RESULT_MODE_JSON = "&mode=json"
typealias DownloadComplete = () -> ()

var CURRENT_WEATHER_URL_BY_CITY_NAME = "\(BASE_URL)\(WEATHER)\(BY_CITY_NAME)\(CITY_NAME)\(API_ID)\(WH_KEY)"

var FORECAST_URL_BY_CITY_NAME = "\(BASE_URL)\(DAILY_FORECAST)\(BY_CITY_NAME)\(CITY_NAME)\(COUNT)\(DAYS_COUNT)\(RESULT_MODE_JSON)\(API_ID)\(WH_KEY)"

var CURRENT_WEATHER_URL_BY_LOCATION = "\(BASE_URL)\(WEATHER)\(LAT)\(Location.sharedInstance.latitude!)\(LON)\(Location.sharedInstance.longitude!)\(API_ID)\(WH_KEY)"

var FORECAST_URL_BY_LOCATION = "\(BASE_URL)\(DAILY_FORECAST)\(LAT)\(Location.sharedInstance.latitude!)\(LON)\(Location.sharedInstance.longitude!)\(COUNT)\(DAYS_COUNT)\(RESULT_MODE_JSON)\(API_ID)\(WH_KEY)"
