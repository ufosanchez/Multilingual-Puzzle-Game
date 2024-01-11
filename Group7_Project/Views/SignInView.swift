//
//  SignInView.swift
//  FirestoreDemo
//
//  Created by Winona Lee on 2023-03-20.
//

import SwiftUI
import FirebaseFirestore

struct SignInView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    
    @State private var email : String = ""
    @State private var password  :String = ""
    @State private var errText :String = ""
    
    @State private var selectedIndex : Int? = nil
    @State private var selectedIndex1 : Int? = nil
    
    @Binding var rootScreen : RootView
    
    private let fireDBHelper = FireDBHelper.getInstance() ?? FireDBHelper(store: Firestore.firestore())
    
    
    var body: some View {
        NavigationView{
            VStack{
//                NavigationLink(destination: ContentView().environmentObject(fireDBHelper), tag: 1, selection: self.$selectedIndex) {}
//
                NavigationLink(destination: SignUpView(rootScreen: self.$rootScreen).environmentObject(self.fireAuthHelper), tag: 2, selection: self.$selectedIndex1) {}
                Text("Sadnosaur's Crossword").bold().font(.system(size: 36))
                Form{
                    TextField("Enter Email", text: self.$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Enter Password", text: self.$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    Text("\(errText)").foregroundColor(.red)
                }// Form
                .disableAutocorrection(true)
                
                Section{
                    HStack{
                        //LazyVGrid(columns: self.gridItems){
                        
                        Button(action: {
                            //validate the data
                            if(!self.email.isEmpty && !self.password.isEmpty) {
                                self.fireAuthHelper.signIn(email: self.email, password: self.password)
                                //navigate to home screen
                                if(self.fireAuthHelper.user != nil){
                                    self.rootScreen = .Home
                                } else {
                                    self.errText = "Login Failed"
                                }
                            } else {
                                //trigger alert displaying errors
                                print(#function, "email and password cannot be empty")
                            }
                        }){
                            Text("Sign In")
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        
                        Spacer()
                        
                        
                        Button(action:{
                            //Take the user to signup screen
                            self.selectedIndex1 = 2
                        }){
                            Text("Sign Up")
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        
                    }.frame(width: 300, height: 100)
                }
                
            }//VStack
            .onAppear{
                self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                self.password = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
                self.errText = ""
            }
        }//Nav
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
