//
//  ListViewModel.swift
//  Check
//
//  Created by Nixon Pastor on 2/8/22.
//

import Foundation

class ListViewModel: ObservableObject{
    @Published var notes: [NoteModel] = []
    
    init(){
        getNotes()
    }
    
    func getNotes(){
        let newNotes = [
            NoteModel(title: "This is the first note", isCompleted: false),
            NoteModel(title: "This is the second note", isCompleted: true),
            NoteModel(title: "This is the third note", isCompleted: false)
        ]
        notes.append(contentsOf: newNotes)
    }
    
    func deleteNote(indexSet: IndexSet){
        notes.remove(atOffsets: indexSet)
    }
    
    func moveNote(from: IndexSet, to: Int){
        notes.move(fromOffsets: from, toOffset: to)
    }
}