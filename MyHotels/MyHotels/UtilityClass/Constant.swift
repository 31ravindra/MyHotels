//
//  Constant.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 25/05/21.
//

import Foundation

struct Constants {
    
    struct storyBoardConstants {
       static let storyBoardName = "Main"
    }
    struct viewControllersIdentifiers {
        static let addHotelVC  = "AddHotelViewController"
    }
    struct entityConstant {
        static let entityName = "Hotel"
        static let nameAttribute = "name"
        static let ratingAttribute = "rating"
        static let imgDataAttribute = "img"
        static let addressAttibute = "address"
        static let roomrateAttribute = "roomrate"
        static let staydateAttribute = "staydate"
        static let isfavouriteAttribute = "isfavourite"
        static let isVisitedAttribute = "isVisited"
    }
    
    struct UIMessageConstant {
        static let dataSavedMsg = "Data Saved"
        static let dataUpdateMsg = "Data Updated"
        static let emptyFieldMsg = "Please add atleast Name"
    }
    
    struct NavigatioTitle {
        static let addHotelTitle = "Add Hotel"
        static let editHotelTitle = "Edit Hotel"
    }
    
    
}
