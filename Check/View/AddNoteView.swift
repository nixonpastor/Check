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
    
    @State var textFieldString: String = ""
    var body: some View {
        ScrollView{
            VStack{
                TextEditor(text: $textFieldString)
                    .placeholder(when: textFieldString.isEmpty){
                        Text("Enter Note Here").foregroundColor(.white)
                            .opacity(0.6)
                            .padding(.bottom, 330)
                            .padding(.horizontal, 10)
                    }
                    .padding(.horizontal)
                    .padding()
                    .frame(height: 400)
                    .foregroundColor(.white)
                    .background(Color(0x212423))
                    .cornerRadius(10)
                

                
                Button(action: {
                }, label: {
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
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        AddNoteView()
        }
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
