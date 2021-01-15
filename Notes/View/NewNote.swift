//
//  NewNote.swift
//  Notes
//
//  Created by Matheus Valbert on 14/01/21.
//

import SwiftUI

struct NewNote: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var homeData = HomeViewModel()
    
    @Binding var isPresented: Bool
    
    @State var title: String = ""
    @State var note: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Título:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                TextField("", text: $title)
                    .padding()
                    .background(Color(UIColor.lightGray))
                    .cornerRadius(5.0)
                    .padding()
                
                Text("Nota:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                MultiLineTF(txt: $note)
                    .padding()
                    .background(Color(UIColor.lightGray))
                    .cornerRadius(5.0)
                    .padding()
            }.navigationBarTitle("Nova Nota", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("OK", action: {
                        homeData.createData(title: title, note: note)
                        isPresented.toggle()
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar", action: {
                        isPresented.toggle()
                    })
                }
            }.padding()
        }
    }
}
