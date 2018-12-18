//
//  WeatherTableViewCell.swift
//  AppWeather
//
//  Created by Can Bas on 11/13/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherName: UILabel!
    @IBOutlet weak var weatherDegree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
