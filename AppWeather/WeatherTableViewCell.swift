//
//  WeatherTableViewCell.swift
//  AppWeather
//
//  Created by Can Bas on 11/13/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

 
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherName: UILabel!
    @IBOutlet weak var weatherDegree: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //TODO: setcell

}
