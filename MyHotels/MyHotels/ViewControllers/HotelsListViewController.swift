//
//  HotelsListViewController.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import UIKit

class HotelsListViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addHotel(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let dddHotelViewController = storyBoard.instantiateViewController(withIdentifier: "AddHotelViewController") as! AddHotelViewController
        self.navigationController?.pushViewController(dddHotelViewController, animated: true)
    }
    
}
