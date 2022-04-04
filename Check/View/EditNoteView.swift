//
//  EditNoteView.swift
//  Check
//
//  Created by Nixon Pastor on 4/4/22.
//

import SwiftUI

struct EditNoteView: View {
    init(currentNote: ObservedObject<NoteModel> ) {
            UITextView.appearance().backgroundColor = .clear
          self._currentNote = currentNote
        }

    
    //To Navigate back to notes page
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel: ListViewModel
  
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    @ObservedObject var currentNote: NoteModel
    
    var body: some View {
        ScrollView{
            VStack{
                TextEditor(text: $currentNote.title)
                    .padding(.horizontal)
                    .padding()
                    .frame(height: 400)
                    .foregroundColor(.white)
                    .background(Color(0x212423))
                    .cornerRadius(10)
                

                
                Button(action: saveButtonPressed, label: {
                    Text("Save Edit".uppercased())
                        .frame(height: 55)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            .padding(16)
        }.padding(.top, 100)
        .navigationTitle("Edit a Note")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    //add note to listviewmodel
    func saveButtonPressed(){
        if isAppropriateText() {
//            listViewModel.addNote(title: textFieldString)
            listViewModel.updateNote(note: currentNote)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //check if 3 characters or more
    func isAppropriateText() -> Bool {
        if currentNote.title.count < 3 {
            alertTitle = "Note must be at least 3 characters long."
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
//            EditNoteView(textFieldString: "sample")
        }.environmentObject(ListViewModel())
    
    }
}
