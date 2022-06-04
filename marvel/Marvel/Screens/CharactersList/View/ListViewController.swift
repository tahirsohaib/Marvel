//
//  ViewController.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import UIKit

private enum Section {
    case squad
    case list
}

class ListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    fileprivate var sections: [Section] = [.list]

    lazy var viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        setupNavbar()
    }

    func initViewModel() {
        view.showHUD()
        viewModel.getCharacters()
        viewModel.reloadTableView = { [weak self] in
            if self?.viewModel.squad.count != 0 {
                self?.sections = [.squad, .list]
            } else {
                self?.sections = [.list]
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.view.hideHUD()
            }
        }
        viewModel.errorAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.view.hideHUD()
            }
            self?.alert(error)
        }
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .squad:
            return 195
        case .list:
            return 100
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(character: viewModel.getCellCharacterModel(at: indexPath))
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .squad:
            return 1
        case .list:
            return viewModel.characters.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .squad:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListSquadCell.identifier, for: indexPath) as? ListSquadCell else { fatalError("xib does not exists") }
            cell.characters = viewModel.squad
            cell.didSelectCell = { index in
                self.navigateToDetail(character: self.viewModel.getSquadCharacterModel(at: IndexPath(row: index, section: 0)))
            }
            return cell
        case .list:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as? ListViewCell else { fatalError("xib does not exists") }
            let character = viewModel.getCellCharacterModel(at: indexPath)
            cell.character = character
            return cell
        }
    }
}

extension ListViewController {
    private func navigateToDetail(character: CharacterModel) {
        let detailViewModel = DetailViewModel(squadService: SquadFetcher(), character: character)
        let detailVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailViewController") as? DetailViewController
        detailVC?.viewModel = detailViewModel
        detailVC?.didUpdateSquad = { [weak self] in
            self?.viewModel.loadSquad()
        }
        navigationController?.pushViewController(detailVC!, animated: true)
    }
}

extension ListViewController {
    private func setupNavbar() {
        let titleImageView = UIImageView(image: UIImage(named: "marvel-logo"))
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }
}
