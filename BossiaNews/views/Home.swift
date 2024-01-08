//
//  Home.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 5.01.2024.
//

import UIKit
import Kingfisher
import RxSwift


class Home: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var newsList = [Article]()
    var viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        viewModel.uploadNews()
        
        viewModel.newList
                    .subscribe(onNext: { [weak self] articles in
                        self?.newsList = articles
                        self?.tableView.reloadData()
                    })
                    .disposed(by: disposeBag)
    }
}
extension Home: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.titleLabel.text = news.title
        cell.dateLabel.text = news.publishedAt
        cell.descriptionLabel.text = news.description
        if let imageUrl = URL(string: news.urlToImage ?? "") {
            cell.thumbnailImageView.kf.setImage(with: imageUrl)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
