//
//  CollectionViewCell.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import UIKit

class SquadCollectionViewCell: UICollectionViewCell {
    class var identifier: String { return String(describing: self) }
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView! {
        didSet {
            imgView.layer.cornerRadius = imgView.frame.size.height / 2
            imgView.clipsToBounds = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
}
