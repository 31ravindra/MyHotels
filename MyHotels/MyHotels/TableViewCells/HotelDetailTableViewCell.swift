//
//  HotelDetailTableViewCell.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import UIKit

class HotelDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHotel: UIImageView!
    
    @IBOutlet weak var lblNameHotel: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
