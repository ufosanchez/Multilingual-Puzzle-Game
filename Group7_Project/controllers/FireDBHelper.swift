//
//  FireDBHelper.swift
//  FirestoreDemo
//
//  Created by Winona Lee on 2023-03-20.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

class FireDBHelper : ObservableObject {
    
    @Published var profile = Profile()
    @Published var picture = UIImage()
    @Published var sharedProfile = [Profile]()
    
    private let store : Firestore
    private static var shared : FireDBHelper?
    
    private let COLLECTION_USER : String = "User_Profile"
    private let COLLECTION_USER_LOCATION : String = "User_Location"
    
    private let FIELD_NAME : String = "pName"
    private let FIELD_GENDER : String = "pGender"
    private let FIELD_AGE : String = "pAge"
    private let FIELD_LANGUAGE : String = "pLanguage"
    private let FIELD_LAT : String = "pLat"
    private let FIELD_LOG : String = "pLog"
    
    var loggedInUserEmail : String = ""
    private let COLLECTION_SCORE_USER : String = "User_Score"
    
    private let COLLECTION_LEVEL : String = "Level_Score"
    private let COLLECTION_SCORE : String = "All_Score"

    //------------------
    
    @Published var levelScoreList = [LevelStore]()
    @Published var userScoreList = [LevelStore]()
    
    init(store: Firestore) {
        self.store = store
    }
    
    static func getInstance() -> FireDBHelper?{
        if (shared == nil){
            shared = FireDBHelper(store: Firestore.firestore())
        }
        
        return shared
    }
    
   
    
    
    func getProfile(withCompletion completion: @escaping (Profile?) -> Void){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        let docRef = self.store
            .collection(COLLECTION_USER)
            .document(loggedInUserEmail)
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                self.profile.pName = document["pName"] as? String ?? ""
                self.profile.pGender = document["pGender"] as? String ?? ""
                self.profile.pAge = document["pAge"] as? Int ?? 0
                self.profile.pLanguage = document ["pLanguage"] as? [String] ?? [""]
                print("Document data: \(dataDescription)")
                DispatchQueue.main.async() {
                    completion(self.profile)
                }

            } else {
                print("Document does not exist")
                self.profile.pName = ""
                self.profile.pGender = ""
                self.profile.pAge = 1
                self.profile.pLanguage = [""]
            }
        }
        
    }
    
    func updateProfile(profileToUpdate : Profile){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        let docRef = self.store
            .collection(COLLECTION_USER)
            .document(loggedInUserEmail)

        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                    docRef
                    .updateData([FIELD_NAME : profileToUpdate.pName,
                              FIELD_GENDER : profileToUpdate.pGender,
                                FIELD_AGE : profileToUpdate.pAge,
                             FIELD_LANGUAGE : profileToUpdate.pLanguage]) { error in
                        if let error = error {
                            print(#function, "Unable to update document : \(error)")
                        } else {
                            print(#function, "Successfully update document")
                        }
                    }
            } else {
                print("Document does not exist")
                do {
                    try self.store
                        .collection(COLLECTION_USER)
                        .document(loggedInUserEmail)
                        .setData ([FIELD_NAME : profileToUpdate.pName,
                                   FIELD_GENDER : profileToUpdate.pGender,
                                   FIELD_AGE : profileToUpdate.pAge,
                                   FIELD_LANGUAGE : profileToUpdate.pLanguage])
                } catch let error as NSError {
                    print(#function, "Unable to add document to firestore : \(error)")
                }
            }
        }
        
    }
    
    func uploadPic(profilePic : UIImage){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        guard let imageData = profilePic.jpegData(compressionQuality: 0.5) else {return}
        let profileImgReference = Storage.storage().reference().child("profile_image_urls").child("\(loggedInUserEmail).png")
                let uploadTask = profileImgReference.putData(imageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    profileImgReference.downloadURL { url, err in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                    }
                        
                    
                }
                uploadTask.observe(.progress, handler: { (snapshot) in
                    print(snapshot.progress?.fractionCompleted ?? "")
                   
                })
    }
    
    func getPic(withCompletion completion: @escaping (UIImage?) -> Void){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        let profileImgReference = Storage.storage().reference().child("profile_image_urls").child("\(loggedInUserEmail).png")
        profileImgReference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
                if let err = error {
                   print(err)
                    self.picture = UIImage()
              } else {
                if let image = data {
                     let myImage: UIImage! = UIImage(data: image)

                     // Use Image
                    self.picture = myImage
                    DispatchQueue.main.async() {
                        completion(self.picture)
                    }
                }
             }
        }
        
    }
    
    func uploadUserLocation(profileToUpdate: Profile){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        let docRef = self.store
            .collection(COLLECTION_USER_LOCATION)
            .document(loggedInUserEmail)

        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                    docRef
                    .updateData([FIELD_NAME : profileToUpdate.pName,
                              FIELD_GENDER : profileToUpdate.pGender,
                                FIELD_AGE : profileToUpdate.pAge,
                             FIELD_LANGUAGE : profileToUpdate.pLanguage,
                                FIELD_LAT : profileToUpdate.pLat,
                                FIELD_LOG : profileToUpdate.pLog]
                    ) { error in
                        if let error = error {
                            print(#function, "Unable to update document : \(error)")
                        } else {
                            print(#function, "Successfully update document")
                        }
                    }
            } else {
                print("Location does not exist")
                do {
                    try self.store
                        .collection(COLLECTION_USER_LOCATION)
                        .document(loggedInUserEmail)
                        .setData ([FIELD_NAME : profileToUpdate.pName,
                                   FIELD_GENDER : profileToUpdate.pGender,
                                   FIELD_AGE : profileToUpdate.pAge,
                                   FIELD_LANGUAGE : profileToUpdate.pLanguage,
                                    FIELD_LAT : profileToUpdate.pLat,
                                    FIELD_LOG : profileToUpdate.pLog])
                } catch let error as NSError {
                    print(#function, "Unable to add document to firestore : \(error)")
                }
            }
        }
    }
    
    func getSharedUsers(){
        
        let docRef = self.store
            .collection(COLLECTION_USER_LOCATION)
            
        
            .addSnapshotListener({ (querySnapshot, error) in
                
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from Firestore : \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach{ (docChange) in
                    
                    do{
                        var profile : Profile = try docChange.document.data(as: Profile.self)
                        
                        let docID = docChange.document.documentID
                        profile.id = docID
                        
                        self.sharedProfile.append(profile)
                        
                        
                    }catch let err as Error{
                        print(#function, "Unable to convert the document into object : \(err)")
                    }
                }
                
            })
    }
    
    func insertScoreLevel(collectionLevel : String, newScore : LevelStore){
        print(#function, "Trying to insert score to firestore")

        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        //self.loggedInUserEmail = "dinosaur@gmail.com"

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            do{
                try self.store
                    .collection(COLLECTION_LEVEL)
                    .document(collectionLevel)
                    .collection(COLLECTION_SCORE)
                    .addDocument(from : newScore)
            }catch let error as NSError{
                print(#function, "Unable to add document to firestore : \(error)")
            }
        }
    }
    
    func insertScoreUserLevel(collectionLevel : String, newScore : LevelStore){
        print(#function, "Trying to insert score to firestore")

        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        //self.loggedInUserEmail = "dinosaur@gmail.com"

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            do{
                try self.store
                    .collection(COLLECTION_USER)
                    .document(loggedInUserEmail)
                    .collection(collectionLevel)
                    .addDocument(from : newScore)
            }catch let error as NSError{
                print(#function, "Unable to add document to firestore : \(error)")
            }
        }
    }
    func getAllScore(collectionLevel : String){
        self.levelScoreList.removeAll()

        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        //self.loggedInUserEmail = "dinosaur@gmail.com"

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            self.store
                .collection(COLLECTION_LEVEL)
                .document(collectionLevel)
                .collection(COLLECTION_SCORE)
                .order(by: "pScore", descending: true)
//                .order(by: "dateAdded", descending: true)
                .addSnapshotListener({ (querySnapshot, error) in

                    guard let snapshot = querySnapshot else {
                        print(#function, "Unable to retrieve data from Firestore : \(error)")
                        return
                    }

                    snapshot.documentChanges.forEach{ (docChange) in

                        do{
                            var score : LevelStore = try docChange.document.data(as: LevelStore.self)

                            let docID = docChange.document.documentID
                            score.id = docID

                            let matchedIndex = self.levelScoreList.firstIndex(where: {
                                ($0.id?.elementsEqual(docID))! })

                            if docChange.type == .added{
                                self.levelScoreList.append(score)
                                print(#function, "Document added : \(score)")
                            }

                            if docChange.type == .removed{
                                if (matchedIndex != nil){
                                    self.levelScoreList.remove(at: matchedIndex!)
                                }
                            }

                            if docChange.type == .modified{
                                if (matchedIndex != nil){
                                    self.levelScoreList[matchedIndex!] = score
                                }
                            }

                        }catch let err as Error{
                            print(#function, "Unable to convert the document into object : \(err)")
                        }
                    }
                })
        }
    }
    
    func getUserScoreLevel(collectionLevel : String){
        self.userScoreList.removeAll()

       self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        //self.loggedInUserEmail = "dinosaur@gmail.com"

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            self.store
                .collection(COLLECTION_USER)
                .document(loggedInUserEmail)
                .collection(collectionLevel)
                .order(by: "pScore", descending: true)
//                .order(by: "dateAdded", descending: true)
                .addSnapshotListener({ (querySnapshot, error) in

                    guard let snapshot = querySnapshot else {
                        print(#function, "Unable to retrieve data from Firestore : \(error)")
                        return
                    }

                    snapshot.documentChanges.forEach{ (docChange) in

                        do{
                            var score : LevelStore = try docChange.document.data(as: LevelStore.self)

                            let docID = docChange.document.documentID
                            score.id = docID

                            let matchedIndex = self.userScoreList.firstIndex(where: {
                                ($0.id?.elementsEqual(docID))! })

                            if docChange.type == .added{
                                self.userScoreList.append(score)
                                print(#function, "Document added : \(score)")
                            }

                            if docChange.type == .removed{
                                if (matchedIndex != nil){
                                    self.userScoreList.remove(at: matchedIndex!)
                                }
                            }

                            if docChange.type == .modified{
                                if (matchedIndex != nil){
                                    self.userScoreList[matchedIndex!] = score
                                }
                            }

                        }catch let err as Error{
                            print(#function, "Unable to convert the document into object : \(err)")
                        }
                    }
                })
        }
    }
}
