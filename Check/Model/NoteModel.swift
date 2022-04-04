//
//  NoteModel.swift
//  Check
//
//  Created by Nixon Pastor on 2/8/22.
//

import Foundation


struct NoteModel: Identifiable, Codable{
    let id: String
//    let title: String
    var title: String
    let isCompleted: Bool
    
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletition() -> NoteModel {
        return NoteModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}


