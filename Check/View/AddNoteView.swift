//
//  AddNoteView.swift
//  Check
//
//  Created by Nixon Pastor on 2/6/22.
//

import SwiftUI


struct AddNoteView: View {
    init() {
            UITextView.appearance().backgroundColor = .clear
        }
    
    //To Navigate back to notes page
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldString: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextEditor(text: $textFieldString)
                    .placeholder(when: textFieldString.isEmpty){
                        Text("Enter Note Here").foregroundColor(.white)
                            .opacity(0.6)
                            .padding(.bottom, 330)
                            .padding(.horizontal, 6)
                    }
                    .padding(.horizontal)
                    .padding()
                    .frame(height: 400)
                    .foregroundColor(.white)
                    .background(Color(0x212423))
                    .cornerRadius(10)
                

                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
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
        .navigationTitle("Add a Note")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    //add note to listviewmodel
    func saveButtonPressed(){
        if isAppropriateText() {
            listViewModel.addNote(title: textFieldString)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //check if 3 characters or more
    func isAppropriateText() -> Bool {
        if textFieldString.count < 3 {
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

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        AddNoteView()
        }.environmentObject(ListViewModel())
    }
}


//extension to overwrite placeholder for textfield
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
