//
//  FireAuthHelper.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-20.
//


import Foundation
import FirebaseAuth

class FireAuthHelper : ObservableObject {
    
    @Published var user : User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            
            guard let self = self else {
                //no change in auth state
                return
            }
            
            self.user = user
        }
    }
    
    func signUp (email : String, password : String){
        Auth.auth().createUser(withEmail: email, password: password){
            [self] authResult, error in
            
            guard let result = authResult else {
                print(#function, "Error while signing up the user : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to create the account")
            case .some:
                print(#function, "Successfully created user account")
                self.user = authResult?.user
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
        }
    }
    func signIn (email : String, password : String){
        Auth.auth().signIn(withEmail: email, password: password){
            [self] authResult, error in
            
            guard let result = authResult else {
                print(#function, "Error while signing up the user : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to find the account")
            case .some:
                print(#function, "Login Successful")
                self.user = authResult?.user
                
                print(#function, "Welcome \(self.user?.displayName ?? "NA")")
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.user = nil
        }catch let signOutError as NSError {
            print(#function, "unable to sign out user : \(signOutError)")
        }
    }
}
