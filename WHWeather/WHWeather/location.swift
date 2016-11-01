//
//  location.swift
//  WHWeather
//
//  Created by airshiner on 10/19/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import Foundation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude : Double!
    var longitude : Double!
}
