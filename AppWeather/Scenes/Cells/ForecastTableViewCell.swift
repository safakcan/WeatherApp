//
//  ForecastTableViewCell.swift
//  AppWeather
//
//  Created by Can Bas on 11/27/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    //MARK: Outlets

    @IBOutlet weak var futureImagaeCell: UIImageView!
    @IBOutlet weak var futureDateCell: UILabel!
    @IBOutlet weak var futureTempCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
