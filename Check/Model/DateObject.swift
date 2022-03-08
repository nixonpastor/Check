//
//  DateObject.swift
//  Check
//
//  Created by Nixon Pastor on 1/26/22.
//

import SwiftUI

// Date Object

struct DateObject: Identifiable, Codable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
