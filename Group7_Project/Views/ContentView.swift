//
//  ContentView.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-20.
//

import SwiftUI

struct ContentView: View {

    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var locationHelper : LocationHelper
    
    @State private var selectedIndex : Int? = nil
    
    @Binding var rootScreen : RootView
    
    var body: some View {
        VStack{
            NavigationLink(destination: ProfileView().environmentObject(self.fireDBHelper).environmentObject(self.locationHelper), tag: 1, selection: self.$selectedIndex) {}
            NavigationLink(destination: MapView().environmentObject(self.fireDBHelper), tag: 2, selection: self.$selectedIndex) {}
            VStack{
                SplashView()
            }//VStack
            .navigationBarBackButtonHidden(true)
            
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Menu{
                        Button("Profile Settings", action:{self.selectedIndex = 1})
                        Button("Sign Out", action:{self.signOut()})
                        } label: {
                            Image(systemName: "gear")
                        }
                        
                    }
                
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action:{
                        self.selectedIndex = 2
                    }){
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Text("Find Players nearby")
                        }
                    }
                }
            }
//            .navigationTitle("Main")
        }//VStack
        .onAppear(){
            self.fireDBHelper.getPic(withCompletion: {pic in
                print(#function, "onAppear - Picture data : \(pic)")
            })
            self.fireDBHelper.getProfile(withCompletion: {profile in
                print(#function, "onAppear - Profile data : \(profile)")
            })
            
            print("\(self.locationHelper.authorizationStatus)")
        }
        .onChange(of: self.locationHelper.currentLocation, perform: { _ in
            print(#function, "current location changed : \(self.locationHelper.currentLocation)")
        })
    }
    private func signOut(){
        self.fireAuthHelper.signOut()
        self.fireDBHelper.picture = UIImage()
        //dismiss current view and go back to Sign In View
        self.rootScreen = .Login
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
