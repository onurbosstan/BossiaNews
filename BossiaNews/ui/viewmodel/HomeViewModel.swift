//
//  HomeViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 5.01.2024.
//

import Foundation
import RxSwift

class HomeViewModel {
    var nrepo = NewsRepo()
    var newList = BehaviorSubject<[Article]>(value: [Article]())
    var isLoading = BehaviorSubject<Bool>(value: false)
    func uploadNews() {
        nrepo.uploadNews { [weak self] articles in
            self?.isLoading.onNext(false)
            self?.newList.onNext(articles)
        }
    }
    func uploadCategoryNews(category: String) {
        nrepo.uploadCategoryNews(category: category) { [weak self] articles in
            self?.isLoading.onNext(false)
            self?.newList.onNext(articles)
        }
    }
}
