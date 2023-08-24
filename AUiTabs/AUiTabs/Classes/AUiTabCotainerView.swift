//
//  AUiTabCotainerView.swift
//  AUiTabs
//
//  Created by zhaoyongqiang on 2023/8/18.
//

import UIKit

protocol AUiTabContainerViewDelegate: NSObjectProtocol {
    /// tab标题
    func titles() -> [String]
    /// 列表的容器视图的数量
    func numberOfListsInListContainerView() -> Int
    /// 显示的view
    func listContainerView(index: Int) -> UIView
    /// 滚动后回调
    func onScrollChange(to index: Int)
    /// 点击标题回调
    func onDidTitleItem(to index: Int)
}

class AUiTabCotainerView: UIView {
    // MARK: Public
    weak var delegate: AUiTabContainerViewDelegate? {
        didSet {
            tabsView.titles = delegate?.titles() ?? []
        }
    }
    public var tabStyle: AUiTabsStyle = .init() {
        didSet {
            tabsView.style = tabStyle
        }
    }
    
    // MARK: Private
    private lazy var tabsView: AUiTabs = {
        let tabs = AUiTabs()
        tabs.onScrollChangeClosure = { [weak self] index in
            self?.delegate?.onScrollChange(to: index)
        }
        tabs.onDidItemClosure = {[weak self] index in
            self?.delegate?.onDidTitleItem(to: index)
            self?.containerView.scrollToPage(index: index)
        }
        return tabs
    }()
    
    private lazy var containerView: AUiTabBaseView = {
        let containerView = AUiTabBaseView()
        containerView.delegate = self
        return containerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tabsView)
        tabsView.translatesAutoresizingMaskIntoConstraints = false
        tabsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        tabsView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tabsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: tabsView.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
extension AUiTabCotainerView: AUiTabBaseViewDelegate {
    func numberOfListsInListContainerView() -> Int {
        delegate?.numberOfListsInListContainerView() ?? 0
    }
    
    func listContainerView(index: Int) -> UIView {
        delegate?.listContainerView(index: index) ?? UIView()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        tabsView.scrollToPage(point: scrollView.contentOffset)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        tabsView.scrollToPosition(point: scrollView.contentOffset)
    }
}
