//
//  forcastCell.swift
//  WHWeather
//
//  Created by airshiner on 10/29/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit

class forcastCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    func configureCell(forcast: forcastData) {
        minTemp.text = forcast.lowTemp
        maxTemp.text = forcast.highTemp
        weatherType.text = forcast.weatherType
        dayLabel.text = forcast.date
        let imageName = "\(forcast.weatherType) Mini"
        weatherIcon.image = UIImage(named: imageName)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
