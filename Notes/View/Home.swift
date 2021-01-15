//
//  Home.swift
//  Notes
//
//  Created by Matheus Valbert on 13/01/21.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var homeData = HomeViewModel()
    
    @State var isPresented = false
    
    init() {
        homeData.fetchData()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(homeData.notes) { note in
                    NavigationLink(destination: EditNote(note: note)) {
                        Text(note.title)
                    }
                }.onDelete(perform: { indexSet in
                    homeData.deleteData(id: indexSet)
                })
            }
            .navigationBarTitle("Notas", displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "square.and.pencil")
                    })
                }
            }
        }.sheet(isPresented: $isPresented, content: { NewNote(isPresented: self.$isPresented) })
    }
}
