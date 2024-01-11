//
//  MainView.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct MainView: View {
    
    private let fireDBHelper = FireDBHelper.getInstance() ?? FireDBHelper(store: Firestore.firestore())
    private let fireAuthHelper = FireAuthHelper()
    private let locationHelper = LocationHelper()
    
    @State private var root : RootView = .Login
    
    var body: some View {
        NavigationView{
            switch root{
            case .Login:
                SignInView(rootScreen : $root).environmentObject(fireAuthHelper)
            case .Home:
                ContentView(rootScreen : $root).environmentObject(fireAuthHelper).environmentObject(fireDBHelper).environmentObject(locationHelper)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
