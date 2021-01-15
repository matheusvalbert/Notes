//
//  HomeViewModel.swift
//  Notes
//
//  Created by Matheus Valbert on 13/01/21.
//

import Foundation
import Firebase

struct Note: Codable, Identifiable {
    var id: String
    var title: String
    var note: String
}

class HomeViewModel: ObservableObject {
    
    @Published var notes = [Note]()
    private let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("Notes").addSnapshotListener({(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print ("no notes returned!")
                return
            }
            
            self.notes = documents.map({docSnapshot -> Note in
                let data = docSnapshot.data()
                let docId = docSnapshot.documentID
                let title = data["title"] as? String ?? ""
                let note = data["note"] as? String ?? ""
                return Note(id: docId, title: title, note: note)
            })
        })
    }
    
    func updateData(id: String, note: String) {
        db.collection("Notes").document(id).updateData(["note" : note]);
    }
    
    func createData(title: String, note: String) {
        db.collection("Notes").addDocument(data: ["title" : title, "note" : note])
    }
    
    func deleteData(id: IndexSet) {
        for offset in id {
            db.collection("Notes").document(notes[offset].id).delete()
        }
    }
}
