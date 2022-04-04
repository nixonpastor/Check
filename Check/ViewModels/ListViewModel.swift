//
//  ListViewModel.swift
//  Check
//
//  Created by Nixon Pastor on 2/8/22.
//

import Foundation

class ListViewModel: ObservableObject{
    @Published var notes: [NoteModel] = [] {
        didSet{
            saveItems()
        }
    }
    
    let notesKey: String = "notes_list"
    
    init(){
        getNotes()
    }
    
    func getNotes(){
        guard
            let data = UserDefaults.standard.data(forKey: notesKey),
            let savedItems = try? JSONDecoder().decode([NoteModel].self, from: data)
        else {
            return
        }
        
        self.notes = savedItems
    }
    
    func deleteNote(indexSet: IndexSet){
        notes.remove(atOffsets: indexSet)
    }
    
    func moveNote(from: IndexSet, to: Int){
        notes.move(fromOffsets: from, toOffset: to)
    }
    
    func addNote(title: String){
        let newNote = NoteModel(title: title, isCompleted: false)
        notes.append(newNote)
    }
    
    
    func updateNote(note: NoteModel){
        if let index = notes.firstIndex(where: { $0.id == note.id}){
            notes[index] = NoteModel(id: note.id, title: note.title, isCompleted: false)
        }
    }
    
    func updateTrigger(note: NoteModel, completition: Bool){
        if let index = notes.firstIndex(where: { $0.id == note.id}){
            notes[index] = NoteModel(id: note.id, title: note.title, isCompleted: !completition)
        }
    }
    
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encodedData, forKey: notesKey)
        }
    }
}
