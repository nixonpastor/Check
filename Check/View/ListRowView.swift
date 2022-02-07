//
//  ListRowView.swift
//  Check
//
//  Created by Nixon Pastor on 2/6/22.
//

import SwiftUI

struct ListRowView: View {
    
    let title: String
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle")
            Text(title)
            Spacer()
        }
//        .padding()
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "First Item")
    }
}
