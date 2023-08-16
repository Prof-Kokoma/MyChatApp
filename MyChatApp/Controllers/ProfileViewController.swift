//
//  ProfileViewController.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        viewModel = profileViewModel
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    private func layoutTableView() {
        tableView.fillSuperView()
    }
    
    func logoutUser() {
        viewModel?.signOut { [weak self] in
            guard let self else { return }
            display(vc: LoginViewController())
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let actionSheet = UIAlertController(title: "Sign Out", message: "Are you sure?", preferredStyle: .actionSheet)
        actionSheet.addAction(.init(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            guard let self else { return }
            logoutUser()
        }))
        actionSheet.addAction(.init(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    
}
