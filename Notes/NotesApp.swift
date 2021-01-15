//
//  NotesApp.swift
//  Notes
//
//  Created by Matheus Valbert on 13/01/21.
//

import SwiftUI
import Firebase

@main
struct NotesApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
