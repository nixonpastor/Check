//
//  ListRowView.swift
//  Check
//
//  Created by Nixon Pastor on 2/6/22.
//

import SwiftUI

struct ListRowView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @ObservedObject var note: NoteModel
    
    var body: some View {
        HStack{
            NavigationLink(destination: EditNoteView(currentNote: _note)){
            Image(systemName: note.isCompleted ? "checkmark.circle" : "circle")
                .onTapGesture {
                    withAnimation(.linear){
                        listViewModel.updateTrigger(note: note, completition: note.isCompleted)
                    }
                }
                .foregroundColor(note.isCompleted ? .green : .red)
            (note.title.count > 14) ?
            Text(note.title.prefix(14) + " ...")
            :
            Text(note.title)

            Spacer()
            }
        }
        .font(.title2)
        .padding(.vertical, 8)
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var note1 = NoteModel(title: "Note 1", isCompleted: false)
    static var note2 = NoteModel(title: "Note 2", isCompleted: true)

    static var previews: some View {
        Group{
//            ListRowView(note: note1)
//            ListRowView(note: note2)
        }.previewLayout(.sizeThatFits)
    }
}
