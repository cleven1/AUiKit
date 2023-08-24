//
//  ViewController.swift
//  AUiGiftToast
//
//  Created by zhaoyongqiang on 2023/4/11.
//

import UIKit

class ViewController: UIViewController {
    private lazy var giftView = AUiGiftView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(giftView)
        giftView.translatesAutoresizingMaskIntoConstraints = false
        giftView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        giftView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        giftView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        giftView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private var dataArray: [AUiGiveGiftEntity] = (1...3).map({ item in
        let gift = AUiGiveGiftEntity(senderName: "发送者\(item)",
                                     senderURL: "icon\(item)",
                                     giftName: "送出礼物：【\("🚀")】",
                                     giftURL: "prop_b")
        return gift
    })
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        giftView.showGiftEntity(entity: dataArray.randomElement()!)
    }
}

