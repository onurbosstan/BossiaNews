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
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var newsList = [Article]()
    var viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    var lastTapTime: Date? //İki tıklama arasındaki zaman aralığını kontrol etmek için
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.delegate = self
        viewModel.uploadNews()
        viewModel.newList.subscribe(onNext: { [weak self] articles in
                        self?.newsList = articles
                        self?.tableView.reloadData()
                    })
                    .disposed(by: disposeBag)
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
                        if isLoading {
                            Animation.showActivityIndicator()
                        } else {
                            Animation.hideActivityIndicator()
                        }
                    })
                    .disposed(by: disposeBag)
    }
    @IBAction func menuButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Category", message: "Please select the news category you want to read.", preferredStyle: .actionSheet)
            let economyAction = UIAlertAction(title: "Economy", style: .default) { _ in
                self.viewModel.uploadCategoryNews(category: "economy")
                self.selectedCategoryLabel.text = "Economy"
            }
            let techCrunchAction = UIAlertAction(title: "TechCrunch", style: .default) { _ in
                self.viewModel.uploadCategoryNews(category: "techcrunch")
                self.selectedCategoryLabel.text = "TechCrunch"
            }
            let articlesAction = UIAlertAction(title: "Articles", style: .default) { _ in
                self.viewModel.uploadCategoryNews(category: "articles")
                self.selectedCategoryLabel.text = "Articles"
            }
            let technologyAction = UIAlertAction(title: "Technology", style: .default) { _ in
                self.viewModel.uploadCategoryNews(category: "technology")
                self.selectedCategoryLabel.text = "Technology"
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(economyAction)
            alertController.addAction(techCrunchAction)
            alertController.addAction(articlesAction)
            alertController.addAction(technologyAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
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
//TabBarItem basınca tabloyu en üste getirmek için;
extension Home: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is Home {
            scrollToTop()
        }
    }
    func scrollToTop() {
        let currentTime = Date()
        if let lastTapTime = lastTapTime, currentTime.timeIntervalSince(lastTapTime) < 0.7 { //İki tıklama arasındaki zaman aralığını kontrol et
            // Çift tıklama algılandığında, tabloyu en üstüne getir
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.lastTapTime = nil // Şu anki tıklama zamanını sıfırla
        } else {
            self.lastTapTime = currentTime // Şu anki tıklama zamanını kaydet
        }
    }
}



