//
//  ListViewCell.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import SDWebImage
import UIKit

class ListViewCell: UITableViewCell {
    @IBOutlet var holderView: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    class var identifier: String { return String(describing: self) }

    var character: CharacterModel? {
        didSet {
            holderView.layer.cornerRadius = 10
            lblTitle.text = character?.name
            imgView.layer.cornerRadius = imgView.frame.size.height / 2
            imgView.sd_setImage(with: URL(string: character!.imageUrl), placeholderImage: UIImage(named: "silhouette"))
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = nil
    }
}
