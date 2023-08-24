//
//  AUiGiveGiftEntity.swift
//  AUiGiftToast
//
//  Created by zhaoyongqiang on 2023/4/11.
//
import UIKit

class AUiGiveGiftEntity: NSObject {
    var senderName: String = ""
    var senderURL: String = ""
    var giftName: String = ""
    var giftURL: String = ""
    
    init(senderName: String,
         senderURL: String,
         giftName: String,
         giftURL: String) {
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AUiGiveGiftEntity else {return false}
        guard object.giftName == giftName && object.senderName == senderName else {return false}
        return true
    }
}
