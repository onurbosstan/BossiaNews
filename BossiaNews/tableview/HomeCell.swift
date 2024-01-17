//
//  HomeCellTableViewCell.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 5.01.2024.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var copyLinkButtonAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func menuButton(_ sender: Any) {
        showMenu()
    }
    func showMenu() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
                return
            }
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let copyLinkAction = UIAlertAction(title: "Copy Link", style: .default) { [weak self] _ in
                self?.copyLinkButtonAction?()
                let alert = UIAlertController(title: "Link Copied", message: nil, preferredStyle: .alert)
                viewController.present(alert, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(copyLinkAction)
            alertController.addAction(cancelAction)
            alertController.popoverPresentationController?.sourceView = viewController.view
            alertController.popoverPresentationController?.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            alertController.popoverPresentationController?.permittedArrowDirections = []
            viewController.present(alertController, animated: true, completion: nil)
    }

}
