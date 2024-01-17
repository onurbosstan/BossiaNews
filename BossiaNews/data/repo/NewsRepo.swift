//
//  NewsRepo.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 3.01.2024.
//

import Foundation
import FirebaseAuth
import RxSwift
import Alamofire
import FirebaseFirestore

class NewsRepo {
    var newsList = BehaviorSubject<[Article]>(value: [Article]())
    
    func signIn(email:String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    func signUp(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        if let mail = email, let password = password {
            let user = Users(email: mail, password: password)
            let data = ["email": user.email, "password": user.password]
            Auth.auth().createUser(withEmail: mail, password: password) { authResult, error in
                if error == nil {
                    let myUsers = Firestore.firestore()
                    let userCollection = myUsers.collection("Users").document(authResult?.user.uid ?? "").collection(user.email)
                    userCollection.document("UserInfo").setData(data) { error in
                        if error != nil {
                            completion(false)
                        }else {
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    func changePassword(newPassword: String, completion: @escaping (Error?) -> Void) {
            if let user = Auth.auth().currentUser {
                user.updatePassword(to: newPassword) { error in
                    completion(error)
                }
            } else {
                completion(nil)
            }
        }
    func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func uploadNews(completion: @escaping ([Article]) -> Void) {
        AF.request("https://newsapi.org/v2/everything?q=apple&from=2024-01-03&to=2024-01-03&sortBy=popularity&apiKey=1fcfc7e446774a01969a8bca74003bac", method: .get).response { response in
            if let data = response.data {
                do {
                    let responses = try JSONDecoder().decode(ArticleResponse.self, from: data)
                    if let list = responses.articles {
                        completion(list)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = response.error {
                print("Network request error: \(error)")
            }
        }
    }
    func uploadCategoryNews(category: String, completion: @escaping ([Article]) -> Void) {
        Animation.showActivityIndicator()
            // Belirli bir kategoriye ait haberleri yükleme
            var url: String
        
            switch category.lowercased() {
            case "economy":
                url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1fcfc7e446774a01969a8bca74003bac"
            case "techcrunch":
                url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1fcfc7e446774a01969a8bca74003bac"
            case "articles":
                url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=1fcfc7e446774a01969a8bca74003bac"
            case "technology":
                url = "https://newsapi.org/v2/everything?q=apple&from=2024-01-03&to=2024-01-03&sortBy=popularity&apiKey=1fcfc7e446774a01969a8bca74003bac"
            default:
                return
            }
            AF.request(url, method: .get).response { response in
                Animation.hideActivityIndicator()
                    if let data = response.data {
                        do {
                            let responses = try JSONDecoder().decode(ArticleResponse.self, from: data)
                            if let list = responses.articles {
                                completion(list)
                            }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    } else if let error = response.error {
                        print("Network request error: \(error)")
                    }
                }
        }
}
