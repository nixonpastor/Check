//
//  NotesView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct NotesView: View {

    @EnvironmentObject var listViewModel: ListViewModel
    
    
    var body: some View {
        
        Color(0x070707).overlay(
            VStack{
                HStack{
                    EditButton().padding().foregroundColor(.white)
                    Spacer()
                    NavigationLink("Add", destination: AddNoteView()).foregroundColor(Color.green).padding()
                }.padding(.top, 10 )
                    .padding(.bottom, -30)
                //Looping through each note
                (listViewModel.notes.count != 0) ?
                AnyView(
                    List{
                    ForEach(listViewModel.notes ) {
                        item in
                        ListRowView(note: item)
                    }
                    .onDelete(perform: listViewModel.deleteNote)
                    .onMove(perform: listViewModel.moveNote)
                }.padding(.top, 20)
                        )
                :
                AnyView(
                    VStack{
                        Text("No Notes Added. Click the Add button to add.").foregroundColor(.white).padding(.top, 290)
                            .padding(.bottom, 450)
                            .font(.headline)

                    }
                )
                        
            }).edgesIgnoringSafeArea(.vertical)
            .padding(.top, -10)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NotesView()
        }.environmentObject(ListViewModel())
    }
}


extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}


