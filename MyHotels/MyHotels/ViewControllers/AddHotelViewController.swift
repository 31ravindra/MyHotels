//
//  AddHotelViewController.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import UIKit

class AddHotelViewController: UIViewController {

    @IBOutlet weak var viewScroll: UIScrollView!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtViewAddress: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtRoomRate: UITextField!
    
    @IBOutlet weak var txtRating: UITextField!
    
    @IBOutlet weak var imgHotel: UIImageView!
    
    let dateFormatter = DateFormatter()
    var selectedDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Hotel"
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
        dateFormatter.dateFormat = "MM/dd/yyyy"
        datePicker.datePickerMode = .date
        
        txtName.layer.borderWidth = 1.0
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRating.layer.borderWidth = 1.0
        txtRating.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRoomRate.layer.borderWidth = 1.0
        txtRoomRate.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewAddress.layer.borderWidth = 1.0
        txtViewAddress.layer.borderColor = UIColor.lightGray.cgColor
        
       
    }
    @IBAction func btnAddPhotoClick(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            DispatchQueue.main.async {
                self.imgHotel.image = image
            }
            }
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        selectedDate = dateFormatter.string(from: (sender as! UIDatePicker).date)
    }
    
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        let name = txtName.text
        let address = txtViewAddress.text
        let imgData = imgHotel.image?.jpegData(compressionQuality: 1.0)
        let rating = txtRating.text
        let price = txtRoomRate.text
        let stayDate = selectedDate
        
        
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
