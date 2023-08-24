//
//  ViewController.swift
//  AUiTabs
//
//  Created by zhaoyongqiang on 2023/4/6.
//

import UIKit

class ViewController: UIViewController {
    private lazy var containerView: AUiTabCotainerView = {
        let containerView = AUiTabCotainerView()
        containerView.delegate = self
        containerView.tabStyle.indicatorStyle = .line
        containerView.tabStyle.indicatorHeight = 3
        containerView.tabStyle.indicatorColor = .purple
        containerView.tabStyle.indicatorWidth = 50
        containerView.tabStyle.selectedTitleColor = .red
        containerView.tabStyle.normalTitleColor = .gray
        containerView.tabStyle.titlePendingHorizontal = 5
        return containerView
    }()
    private var views: [UIView] = (0...10).map({ item -> UIView in
        let view = TestView()
        view.backgroundColor = UIColor(red: CGFloat.random(in: 0...255) / 255.0,
                                       green: CGFloat.random(in: 0...255) / 255.0,
                                       blue: CGFloat.random(in: 0...255) / 255.0,
                                       alpha: 1.0)
        return view
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ViewController: AUiTabContainerViewDelegate {
    func titles() -> [String] {
        (0...10).map({ "测试\($0)" })
    }
    
    func onScrollChange(to index: Int) {
        
    }
    
    func onDidTitleItem(to index: Int) {
        
    }
    
    func numberOfListsInListContainerView() -> Int {
        views.count
    }
    
    func listContainerView(index: Int) -> UIView {
        views[index]
    }
}

class TestView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "沙发啦;身份卡;李开复"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "testCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension TestView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath)
        cell.contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0...255) / 255.0,
                                                   green: CGFloat.random(in: 0...255) / 255.0,
                                                   blue: CGFloat.random(in: 0...255) / 255.0,
                                                   alpha: 1.0)
        return cell
    }
}
    
