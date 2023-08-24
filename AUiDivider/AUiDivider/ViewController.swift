//
//  ViewController.swift
//  AUiDivider
//
//  Created by zhaoyongqiang on 2023/4/13.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TestCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let redView = UIView()
//        redView.backgroundColor = .red
//        view.addSubview(redView)
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        redView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        redView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
//        redView.drawDashLine(strokeColor: .blue,
//                             lineLength: 2,
//                             lineSpacing: 1,
//                             text: "Text",
//                             position: .center)
//        redView.drawLine(strokeColor: .blue, text: "", position: .center)
        
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}


class TestCell: UITableViewCell {
    private lazy var dividerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .red
        contentView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dividerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dividerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        dividerView.drawDashLine(strokeColor: .blue,
                                 lineLength: 2,
                                 lineSpacing: 1,
                                 margin: 20,
                                 text: "测试",
                                 position: .center)
    }
}
