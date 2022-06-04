//
//  SquadCell.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import SDWebImage
import UIKit

class ListSquadCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    class var identifier: String { return String(describing: self) }
    var didSelectCell: ((Int) -> Void)?
    var characters: [CharacterModel]? {
        didSet {
            if let _ = characters {
                collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ListSquadCell: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return characters?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquadCollectionViewCell.identifier, for: indexPath) as? SquadCollectionViewCell
        else { fatalError("view does not exists") }

        let character = characters?[indexPath.row]
        cell.lblTitle.text = character?.name
        cell.imgView.sd_setImage(with: URL(string: character?.imageUrl ?? ""), placeholderImage: UIImage(named: Constants.ImageKeys.silhouette))
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ListSquadCell: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCell?(indexPath.row)
    }
}
