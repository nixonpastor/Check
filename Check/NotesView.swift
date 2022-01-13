//
//  NotesView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        Color(0x070707).overlay(
            VStack{
                Text("Notes View").foregroundColor(.white)
                Image(systemName: "note").resizable().frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.white)
            }).edgesIgnoringSafeArea(.vertical)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
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
