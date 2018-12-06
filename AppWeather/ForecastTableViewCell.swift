//
//  ForecastTableViewCell.swift
//  AppWeather
//
//  Created by Can Bas on 11/27/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var futureImagaeCell: UIImageView!
    @IBOutlet weak var futureDateCell: UILabel!
    @IBOutlet weak var futureTempCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
