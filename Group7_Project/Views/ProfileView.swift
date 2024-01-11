//
//  ProfileView.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-20.
//
import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @State private var name : String = "test title"
    @State private var gender : String = ""
    @State private var age : Int = 1
    @State private var language : [String] = [""]
    @State private var aLanguage : String = ""
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?

    
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    
    var body: some View {
        VStack{
            VStack {
                       PhotosPicker("Select profile picture", selection: $avatarItem, matching: .images)

                       if let avatarImage {
                           Image(uiImage: avatarImage)
                               .resizable()
                               .cornerRadius(150)
                               //.scaledToFit()
                               .frame(width: 150, height: 150)
                               

                       }
                   }
                   .onChange(of: avatarItem) { _ in
                       Task {
                           if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                               if let uiImage = UIImage(data: data) {
                                   avatarImage = uiImage
                                   return
                               }
                           }

                           print("Failed")
                       }
                   }
            Form{
                Section(header: Text("Info")){
                    
                    HStack{
                        Text("Nickname: ").bold()
                        TextField("Enter Name", text: self.$name)
                    }
                    HStack{
                        Text("Gender: ").bold()
                        TextField("Enter Gender", text: self.$gender)
                    }
                   
                    Picker("Enter your age", selection: self.$age){
                        ForEach(1..<100){
                            Text("\($0)")                        }
                    }
//                    TextField("Enter Age", text: self.$age)
                    
                }
                
                Section(header: Text("Languages")){
                    TextField("Add a new language", text: self.$aLanguage)
                    
                    Button(action:{
                        if(!self.language.isEmpty){
                            if(self.language[0] == ""){
                                self.language[0] = self.aLanguage
                            }else{
                                self.language.append(self.aLanguage)
                            }
                        } else {
                            self.language.append(self.aLanguage)
                        }
                        
                    }){
                        Text("Add a language")
                    }
                    Text("Your language(s): ")
                    List {
                        ForEach(self.language, id: \.self) { string in
                            Text(string)
                        }
                        .onDelete(perform: {indexSet in
                            for index in indexSet{
                                self.language.remove(at: index)
                            }
                        })
                    }
                }
                
                Section(header: Text("Location")){
                    Button(action:{
                        self.updateLocation()
                        print(#function, "current location: \(self.locationHelper.currentLocation)")
                    }){
                        Text("Share my location")
                    }
                }
            }//Form ends
            
            
            
            Button(action:{
                if(self.avatarImage != nil){
                    self.fireDBHelper.uploadPic(profilePic: self.avatarImage!)
                }
                self.updateProfile()
                language = [""]
            }){
                Text("Save Profile")
            }
            
            
            Spacer()
        }//VStack ends
        .onAppear(){
            self.name = self.fireDBHelper.profile.pName
            self.gender = self.fireDBHelper.profile.pGender
            self.age = self.fireDBHelper.profile.pAge - 1
            self.language = self.fireDBHelper.profile.pLanguage
            
            if(self.fireDBHelper.picture != UIImage()){
                self.avatarImage = self.fireDBHelper.picture
            } else {
                self.avatarImage = UIImage(named: "default")
            }
        }
        
//        .navigationTitle(Text("Detail View"))
    }//body
    
    private func updateProfile(){
        self.fireDBHelper.profile.pName = self.name
        self.fireDBHelper.profile.pGender = self.gender
        self.fireDBHelper.profile.pAge = self.age + 1
        self.fireDBHelper.profile.pLanguage = self.language
        
        self.fireDBHelper.updateProfile(profileToUpdate: self.fireDBHelper.profile)
        
        dismiss()
        
    }
    
    private func updateLocation(){
        
        self.fireDBHelper.profile.pName = self.name
        self.fireDBHelper.profile.pGender = self.gender
        self.fireDBHelper.profile.pAge = self.age + 1
        self.fireDBHelper.profile.pLanguage = self.language
        self.fireDBHelper.profile.pLat = self.locationHelper.currentLocation?.coordinate.latitude ?? 0.0
        self.fireDBHelper.profile.pLog = self.locationHelper.currentLocation?.coordinate.longitude ?? 0.0
        
        self.fireDBHelper.updateProfile(profileToUpdate: self.fireDBHelper.profile)
        self.fireDBHelper.uploadUserLocation(profileToUpdate: self.fireDBHelper.profile)
        
        
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
