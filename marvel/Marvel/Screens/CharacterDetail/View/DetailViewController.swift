//
//  CharacterDetailViewController.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import SDWebImage
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var actionBtn: UIButton!
    @IBOutlet var tvDescription: UITextView!
    var didUpdateSquad: (() -> Void)?
    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        configureButton()
    }

    func initView() {
        imgView.sd_setImage(with: URL(string: viewModel!.character.imageUrl), placeholderImage: UIImage(named: Constants.ImageKeys.silhouette))
        lblTitle.text = viewModel?.character.name
        tvDescription.text = viewModel?.character.biography
        actionBtn.layer.cornerRadius = 10
    }

    func configureButton() {
        guard let isSquadMember = viewModel?.isSquadMember else { return }
        if isSquadMember {
            setAsFireAction()
        } else {
            setAsRecruitAction()
        }
    }

    @IBAction func tapsActionBtn(_: Any) {
        if viewModel!.isSquadMember {
            presentConfirmation()
        } else {
            viewModel?.recruit()
            didUpdateSquad?()
            configureButton()
        }
    }
}

// MARK: FIRE CONFIRMATION

extension DetailViewController {
    func presentConfirmation() {
        let alertView = UIAlertController(title: "Confirmation", message: "Are you sure you want to remove \(viewModel!.character.name)?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.viewModel?.fire()
            self.didUpdateSquad?()
            self.configureButton()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel)
        alertView.addAction(noAction)
        alertView.addAction(yesAction)
        present(alertView, animated: true)
    }
}

// MARK: Action Button Update

extension DetailViewController {
    private func setAsRecruitAction() {
        actionBtn.setTitle("💪 Recruit to Squad", for: .normal)
        actionBtn.backgroundColor = .systemRed
        actionBtn.layer.borderColor = UIColor.systemRed.cgColor
        actionBtn.layer.borderWidth = 2
    }

    private func setAsFireAction() {
        actionBtn.setTitle("🔥 Fire from Squad", for: .normal)
        actionBtn.backgroundColor = .darkGray
        actionBtn.layer.borderColor = UIColor.systemRed.cgColor
        actionBtn.layer.borderWidth = 2
    }
}
