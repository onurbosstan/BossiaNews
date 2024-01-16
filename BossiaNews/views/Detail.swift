//
//  Detail.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 15.01.2024.
//

import UIKit
import RxSwift

class Detail: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var selectedNews: Article?
    var viewModel = DetailViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}
extension Detail: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        if let selectedNews = try? viewModel.selectedNews.value() {
            cell.titleLabel.text = selectedNews.title
            cell.dateLabel.text = selectedNews.publishedAt
            cell.descriptionLabel.text = selectedNews.description
            if let imageUrl = URL(string: selectedNews.urlToImage ?? "") {
                cell.thumbnailImageView.kf.setImage(with: imageUrl)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
