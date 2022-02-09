//
//  NoteModel.swift
//  Check
//
//  Created by Nixon Pastor on 2/8/22.
//

import Foundation


struct NoteModel: Identifiable{
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
    
}
