//
//  NoteModel.swift
//  Check
//
//  Created by Nixon Pastor on 2/8/22.
//

import Foundation


class NoteModel: ObservableObject, Identifiable, Codable{
    let id: String
//    let title: String
    var title: String
    var isCompleted: Bool
    
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    
}


