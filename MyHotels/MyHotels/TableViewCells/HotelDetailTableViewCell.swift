//
//  HotelDetailTableViewCell.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import UIKit

protocol HotelDetailTableViewCellDelegate: class {
    func didPressFavButton(_ tag: Int)
}


class HotelDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHotel: UIImageView!
    
    @IBOutlet weak var lblNameHotel: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!
    weak var cellDelegate: HotelDetailTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    
    @IBAction func btnFavoriteClicked(_ sender: Any) {
        cellDelegate?.didPressFavButton((sender as! UIButton).tag)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
