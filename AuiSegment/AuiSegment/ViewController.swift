//
//  ViewController.swift
//  AuiSegment
//
//  Created by zhaoyongqiang on 2023/4/4.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let segment = AUiSegmented()
        segment.backgroundColor = .systemPink
        segment.cornerRadius = 22
        view.addSubview(segment)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        segment.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        segment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segment.widthAnchor.constraint(equalToConstant: 180).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        segment.segments = AUiLabelSegment.segments(withTitles: ["Recent", "Nearby", "All"],
                                                 normalTextColor: .white, selectedTextColor: .red)
        
        segment.addTarget(self, action: #selector(segmentValueChanged(sender:)), for: .valueChanged)
        
    }

    @objc
    private func segmentValueChanged(sender: AUiSegmented) {
        print(sender.index)
    }
}

