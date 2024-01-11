//
//  Group7_ProjectApp.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-20.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore




@main
struct Group7_ProjectApp: App {


    
    init(){
        FirebaseApp.configure()

    }
    var body: some Scene {
        WindowGroup {
            MainView()

        }
    }
}

