//
//  HotelsListViewController.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import UIKit
import CoreData
class HotelsListViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    let coreDataHelper = SwiftCoreDataHelper()
    var hotels: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.separatorStyle = .none
        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        coreDataHelper.getData(forEntity: "Hotel", andSaveToArray: &hotels, completion: { [weak self](isComplete) in
            DispatchQueue.main.async {
                if isComplete {
                    self?.tblView.reloadData()
                } else {
                    
                }
            }
        })
        
    }
    func moveToAddEditHotel(isEdit: Bool, hotel: NSManagedObject?) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let addHotelViewController = storyBoard.instantiateViewController(withIdentifier: "AddHotelViewController") as! AddHotelViewController
        addHotelViewController.isComeFromEdit = isEdit
        if let hotel = hotel {
            addHotelViewController.hotel = hotel
        }
        self.navigationController?.pushViewController(addHotelViewController, animated: true)
    }
    @IBAction func addHotel(_ sender: Any) {
        moveToAddEditHotel(isEdit: false, hotel: nil)
    }
    
}


extension HotelsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelDetailTableViewCell", for: indexPath) as! HotelDetailTableViewCell
        let hotel = hotels[indexPath.row]
        cell.lblNameHotel.text = hotel.value(forKey: "name") as? String
        let rating = hotel.value(forKey: "rating")
        if let rat = rating {
            cell.lblRating.text = "Rating = \(rat)"
        }
        let imgData = hotel.value(forKey: "img") as! Data
        let imge = imgData.uiImage
        cell.imageView?.image = imge
        cell.cellDelegate = self
        cell.btnFavorite.tag = indexPath.row
        let isFav = hotel.value(forKey: "isfavourite") as! Bool
        if isFav {
            cell.btnFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.btnFavorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotel = hotels[indexPath.row]
        moveToAddEditHotel(isEdit: true, hotel: hotel)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // remove the item from the data model
            let deleteHotel = hotels[indexPath.row]
            // delete the table view row
            coreDataHelper.deleteData(deleteHotel: deleteHotel, forEntity: "Hotel", completion: {[weak self](isDeleted) in
                DispatchQueue.main.async {
                    self?.hotels.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    // this method handles row deletion
    
}


extension HotelsListViewController: HotelDetailTableViewCellDelegate {
    func didPressFavButton(_ tag: Int) {
        let cell = self.tblView.cellForRow(at: IndexPath(row: tag, section: 0)) as! HotelDetailTableViewCell
        let ishotelFav = hotels[tag].value(forKey: "isfavourite") as! Bool
        
        var hotelModel = HotelModel()
        let hotel = hotels[tag]
        hotelModel.name = hotel.value(forKey: "name") as? String
        
        hotelModel.address = hotel.value(forKey: "address") as? String
        let imgData = hotel.value(forKey: "img") as? Data
        hotelModel.imgData = imgData
        let rating = hotel.value(forKey: "rating") as? Int
        if let rat = rating {
            hotelModel.rating = rat
        }
        let price = hotel.value(forKey: "roomrate") as? Int
        if let rate = price {
            hotelModel.roomRate = rate
        }
        
        let date = hotel.value(forKey: "staydate") as? Date
        if let date = date {
            hotelModel.stayDate = date
        }
        
        if !ishotelFav {
            cell.btnFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
            hotelModel.isFav = true
            coreDataHelper.updateData(forEntity: "Hotel", objectId: hotel.objectID, updateValueTo: hotelModel, andSaveToArray: &hotels, completion: {(isUpdated) in
                
            })
            
        } else {
            cell.btnFavorite.setImage(UIImage(systemName: "star"), for: .normal)
            hotelModel.isFav = false
            coreDataHelper.updateData(forEntity: "Hotel", objectId: hotel.objectID, updateValueTo: hotelModel, andSaveToArray: &hotels, completion: {(isUpdated) in
                
            })
        }
    }
}
