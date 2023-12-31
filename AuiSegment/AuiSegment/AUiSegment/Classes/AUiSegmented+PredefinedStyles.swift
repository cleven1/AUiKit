//
//  AUiSegmented+PredefinedStyles.swift
//  AUiSegmented
//
//  Created by George Marmaridis on 18.10.20.
//

#if canImport(UIKit)

import UIKit

public extension AUiSegmented {
     class func appleStyled(frame: CGRect, titles: [String]) -> AUiSegmented {
        let control = AUiSegmented(
            frame: frame,
            segments: AUiLabelSegment.segments(withTitles: titles),
            options: [.cornerRadius(8)])
        control.indicatorView.layer.shadowColor = UIColor.black.cgColor
        control.indicatorView.layer.shadowOpacity = 0.1
        control.indicatorView.layer.shadowOffset = CGSize(width: 1, height: 1)
        control.indicatorView.layer.shadowRadius = 2
        
        return control
    }
}

#endif
