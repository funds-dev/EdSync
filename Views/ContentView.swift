// Views/ContentView.swift
import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
