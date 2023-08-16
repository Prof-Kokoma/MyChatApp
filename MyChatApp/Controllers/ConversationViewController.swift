//
//  ViewController.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import UIKit
import Combine

class ConversationViewController: UIViewController {

    var vm: ConversationViewModel?
    var cancellables = Set<AnyCancellable>()
    let conversationView = ConversationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Chat"
        view.addSubview(conversationView)
        conversationView.setupTableView(delegate: self, dataSource: self)
        vm = conversationViewModel
        viewModelListener()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm?.getUserLoginState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        conversationView.fillSuperView()
    }
    
    private func viewModelListener() {
        vm?.$isUserLoggedIn
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isUserLoggedIn in
                guard let self else { return }
                if !isUserLoggedIn {
                    let vc = LoginViewController()
                    display(vc: vc)
                }
            })
            .store(in: &cancellables
            )
    }
}

extension ConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.title = "Prof K"
        vc.navigationItem.largeTitleDisplayMode = .never
        pushViewController(vc: vc)
    }
}

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello everyone"
        cell.textLabel?.textAlignment = .left
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}
