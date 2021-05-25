//
//  HotelModel.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import Foundation

struct HotelModel {
    var name: String?
    var address: String?
    var rating: Int?
    var roomRate: Int?
    var imgData: Data?
    var stayDate: Date?
    var isFav: Bool = false
    var isVisited = false
}
