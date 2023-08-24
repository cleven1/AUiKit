//
//  AUiTabCotainerView.swift
//  AUiTabs
//
//  Created by zhaoyongqiang on 2023/8/17.
//

import UIKit

protocol AUiTabBaseViewDelegate: NSObjectProtocol {
    /// 列表的容器视图的数量
    func numberOfListsInListContainerView() -> Int
    /// 显示的view
    func listContainerView(index: Int) -> UIView
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    
    func scrollViewDidScroll(scrollView: UIScrollView)
}

class AUiTabBaseView: UIView {
    weak var delegate: AUiTabBaseViewDelegate?
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "tabCell")
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
    
    public func scrollToPage(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        let width = collectionView.cellForItem(at: indexPath)?.frame.width ?? UIScreen.main.bounds.width
        let point = CGPoint(x: width * CGFloat(index), y: 0.0)
        collectionView.setContentOffset(point, animated: true)
    }
    
    private func setupUI() {
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension AUiTabBaseView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfListsInListContainerView() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath)
        if let view = delegate?.listContainerView(index: indexPath.item),
           !cell.contentView.subviews.contains(where: { $0 == view }) {
            cell.contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating(scrollView: scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating(scrollView: scrollView)
    }
}
