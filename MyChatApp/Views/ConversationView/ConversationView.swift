//
//  ConversationView.swift
//  MyChatApp
//
//  Created by Prof_K on 16/08/2023.
//

import UIKit
import JGProgressHUD

class ConversationView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let noConversationLabel: UILabel = {
        let label = UILabel(text: "No conversation",
                            font: .systemFont(ofSize: 20, weight: .medium),
                            textColor: .gray)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    private var hud: JGProgressHUD?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview([noConversationLabel, tableView])
        fetchConversation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.fillSuperView()
        noConversationLabel.centerXInSuperView()
        noConversationLabel.centerYInSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    private func fetchConversation() {
        tableView.isHidden = false
    }
}

