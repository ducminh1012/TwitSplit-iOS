//
//  Date+extensions.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/15/18.
//  Copyright © 2018 MD. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    func toISOString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    func toString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //Your date format
        let str = dateFormatter.string(from: self)
        
        return str
    }
}
