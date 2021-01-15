//
//  Note.swift
//  Notes
//
//  Created by Matheus Valbert on 13/01/21.
//

import SwiftUI

struct EditNote: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var homeData = HomeViewModel()
    
    let note: Note
    
    @State var txt: String
    
    init(note: Note) {
        self.note = note
        _txt = State(initialValue: note.note)
    }
    
    var body: some View {
        VStack {
            MultiLineTF(txt: $txt)
        }.navigationBarTitle(note.title, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: goBack) {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("Notas")
                                        .font(.body)
                                }
                            }
                        )
    }
    func goBack(){
        homeData.updateData(id: note.id, note: txt)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct MultiLineTF : UIViewRepresentable {
      
      
      func makeCoordinator() -> MultiLineTF.Coordinator {
          
          return MultiLineTF.Coordinator(parent1: self)
      }
      
      @Binding var txt : String
      
      func makeUIView(context: UIViewRepresentableContext<MultiLineTF>) -> UITextView {
          
          let view = UITextView()
          
          if self.txt != ""{
              
              view.text = self.txt
          }
          else{
              
              view.text = ""
          }
          
          view.font = .systemFont(ofSize: 18)
          view.isEditable = true
          view.backgroundColor = .clear
          view.delegate = context.coordinator
          return view
      }
      
      func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTF>) {
          
      }
      
      class Coordinator : NSObject,UITextViewDelegate{
          
          var parent : MultiLineTF
          
          init(parent1 : MultiLineTF) {
              
              parent = parent1
          }
          
          func textViewDidBeginEditing(_ textView: UITextView) {
              
              if self.parent.txt == ""{
                  
                  textView.text = ""
              }
          }
          
          func textViewDidChange(_ textView: UITextView) {
            
            self.parent.txt = textView.text
          }
      }
  }
