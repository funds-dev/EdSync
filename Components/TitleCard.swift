// Components/TitleCard.swift
import SwiftUI

struct TitleCard: View {
    var numberOnline = 20
    var body : some View {
        VStack (alignment: .leading) {
            Text("EdSync Chatroom")
                .font(.title).bold()
            
            Text("\(numberOnline)")
                .font(.caption)
                .foregroundStyle(.green) + Text(" Members Testing").font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
