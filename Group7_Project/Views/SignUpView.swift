//
//  SignUpView.swift
//  FirestoreDemo
//
//  Created by Winona Lee on 2023-03-20.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @State private var email : String = ""
    @State private var password  :String = ""
    @State private var confirmPassword : String = ""
    
    @Binding var rootScreen : RootView
    
    var body: some View {
        
        VStack{
            Text("Create an account").bold()
            Form{
                TextField("Enter Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter Password Again", text: self.$confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }// Form
            .disableAutocorrection(true)
            
            Section{
                Button(action: {
                    //validate the data
                    //inputs not empty
                    //password rule
                    //display alert accordingly
                    
                    //if all data is validated
                    self.fireAuthHelper.signUp(email: self.email, password: self.password)
                    
                    //move to home screen
                    self.rootScreen = .Home
                }){
                    Text("Create Account")
                }// Button ends
                .disabled( self.password != self.confirmPassword && self.email.isEmpty && self.password.isEmpty && self.confirmPassword.isEmpty)
            }
        }// VStack
    }// body
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
