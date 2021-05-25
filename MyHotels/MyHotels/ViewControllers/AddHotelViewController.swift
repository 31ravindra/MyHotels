//
//  AddHotelViewController.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import UIKit
import CoreData
import Foundation

class AddHotelViewController: UIViewController {
    
    @IBOutlet weak var viewScroll: UIScrollView!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtViewAddress: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtRoomRate: UITextField!
    
    @IBOutlet weak var txtRating: UITextField!
    
    @IBOutlet weak var imgHotel: UIImageView!
    
    
    let coreDataHelper = SwiftCoreDataHelper()
    var hotels: [NSManagedObject] = []
    var isComeFromEdit = false
    var hotel = NSManagedObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isComeFromEdit {
        self.navigationItem.title = "Edit Hotel"
        }else {
        self.navigationItem.title = "Add Hotel"
        }
        setUpUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func setUpUI() {
        
        txtViewAddress.delegate = self
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        datePicker.datePickerMode = .date
        txtName.layer.borderWidth = 1.0
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRating.layer.borderWidth = 1.0
        txtRating.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRoomRate.layer.borderWidth = 1.0
        txtRoomRate.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewAddress.layer.borderWidth = 1.0
        txtViewAddress.layer.borderColor = UIColor.lightGray.cgColor
        
        
        if isComeFromEdit {
            txtName.text = hotel.value(forKey: "name") as? String
            txtViewAddress.textColor = .black
            txtViewAddress.text = hotel.value(forKey: "address") as? String
            let imgData = hotel.value(forKey: "img") as? Data
            imgHotel.image = imgData?.uiImage
            let rating = hotel.value(forKey: "rating")
            if let rat = rating {
            txtRating.text = "\(rat)"
            }
            let price = hotel.value(forKey: "roomrate")
            if let rate = price {
                txtRoomRate.text = "\(rate)"
            }
            
            let date = hotel.value(forKey: "staydate") as? Date
            if let date = date {
            datePicker.date = date
            }
            
        }
    }
    
    @IBAction func btnAddPhotoClick(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            DispatchQueue.main.async {
                self.imgHotel.image = image
            }
        }
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        // selectedDate = dateFormatter.string(from: (sender as! UIDatePicker).date)
    }
    
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        var hotelData = HotelModel()
        let name = txtName.text
        let address = txtViewAddress.text
        let imgData = imgHotel.image?.jpegData(compressionQuality: 1.0)
        let rating = txtRating.text
        let price = txtRoomRate.text
        
        hotelData.name = name
        hotelData.imgData = imgData
        hotelData.rating = Int(rating ?? "0")
        hotelData.roomRate = Int(price ?? "0")
        hotelData.address = address
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: datePicker.date)
        let date = formatter.date(from: myString)
        if let date = date {
            hotelData.stayDate = date
        }
        if isComeFromEdit {
            coreDataHelper.updateData(forEntity: "Hotel", objectId: hotel.objectID, updateValueTo: hotelData, andSaveToArray: &hotels, completion: {[weak self](isUpdated) in
                DispatchQueue.main.async {
                    self?.showToast(message: "Data Updated", font: .systemFont(ofSize: 12))
                }
            })
        } else {
        coreDataHelper.save(hotelData: hotelData, useEntity: "Hotel", useArray: &hotels, completion: {[weak self](isSaved) in
            DispatchQueue.main.async {
                self?.showToast(message: "Data Saved", font: .systemFont(ofSize: 12))
            }
        })
        }
        
        
    }
    
}


extension AddHotelViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Enter address here")
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Enter address here"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
