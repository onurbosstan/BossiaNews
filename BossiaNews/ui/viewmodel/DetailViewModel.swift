//
//  DetailViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 15.01.2024.
//

import Foundation
import RxSwift

class DetailViewModel {
    var nrepo = NewsRepo()
    var selectedNews: BehaviorSubject<Article?> = BehaviorSubject<Article?>(value: nil)
}
