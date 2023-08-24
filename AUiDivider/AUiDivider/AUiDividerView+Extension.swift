//
//  AUiDividerView+Extension.swift
//  AUiDivider
//
//  Created by zhaoyongqiang on 2023/4/13.
//

import UIKit

public struct UIRectSide : OptionSet {
    public let rawValue: Int
    public static let left = UIRectSide(rawValue: 1 << 0)
    public static let top = UIRectSide(rawValue: 1 << 1)
    public static let right = UIRectSide(rawValue: 1 << 2)
    public static let bottom = UIRectSide(rawValue: 1 << 3)
    public static let center = UIRectSide(rawValue: 1 << 4)
    public static let all: UIRectSide = [.top, .right, .left, .bottom]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue;
    }
}

extension UIView{
    /// 画虚线边框
    func drawDashLine(strokeColor: UIColor,
                      lineWidth: CGFloat = 1,
                      lineLength: Int = 10,
                      lineSpacing: Int = 5,
                      margin: CGFloat = 10,
                      text: String? = nil,
                      textColor: UIColor? = .black,
                      textFont: UIFont? = .systemFont(ofSize: 14),
                      position: UIRectSide = .bottom) {
        superview?.layoutIfNeeded()
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = .round
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),
                                      NSNumber(value: lineSpacing)]
        let path = CGMutablePath()
        if position.contains(.left) {
            path.move(to: CGPoint(x: 0, y: layer.bounds.height - margin))
            path.addLine(to: CGPoint(x: 0, y: margin))
        }
        if position.contains(.top) {
            path.move(to: CGPoint(x: margin, y: 0))
            path.addLine(to: CGPoint(x: layer.bounds.width - margin, y: 0))
        }
        if position.contains(.right) {
            path.move(to: CGPoint(x: layer.bounds.width, y: margin))
            path.addLine(to: CGPoint(x: layer.bounds.width,
                                     y: layer.bounds.height - margin))
        }
        if position.contains(.bottom) {
            path.move(to: CGPoint(x: layer.bounds.width - margin,
                                  y: layer.bounds.height))
            path.addLine(to: CGPoint(x: margin, y: layer.bounds.height))
        }
        if position.contains(.center) {
            if let text = text, !text.isEmpty {
                let label = UILabel()
                label.text = text
                label.textColor = textColor
                label.font = textFont
                label.textAlignment = .center
                addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                layoutIfNeeded()
                path.move(to: CGPoint(x: layer.bounds.width * 0.5 - margin - label.frame.width * 0.5,
                                      y: layer.bounds.height * 0.5))
                path.addLine(to: CGPoint(x: margin, y: layer.bounds.height * 0.5))
                
                path.move(to: CGPoint(x: layer.bounds.width - margin,
                                      y: layer.bounds.height * 0.5))
                path.addLine(to: CGPoint(x: layer.bounds.width * 0.5 + margin + label.frame.width * 0.5,
                                         y: layer.bounds.height * 0.5))
                
            } else {
                path.move(to: CGPoint(x: layer.bounds.width - margin,
                                      y: layer.bounds.height * 0.5))
                path.addLine(to: CGPoint(x: margin, y: layer.bounds.height * 0.5))
            }
        }
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    /// 画实线边框
    func drawLine(strokeColor: UIColor,
                  lineWidth: CGFloat = 1,
                  margin: CGFloat = 10,
                  text: String? = nil,
                  textColor: UIColor? = .black,
                  textFont: UIFont? = .systemFont(ofSize: 14),
                  position: UIRectSide = .bottom) {
        superview?.layoutIfNeeded()
        if position == UIRectSide.all {
            layer.borderWidth = lineWidth
            layer.borderColor = strokeColor.cgColor
            
        } else {
            let shapeLayer = CAShapeLayer()
            shapeLayer.bounds = bounds
            shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            shapeLayer.fillColor = UIColor.blue.cgColor
            shapeLayer.strokeColor = strokeColor.cgColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.lineJoin = .round

            let path = CGMutablePath()
            if position.contains(.left) {
                path.move(to: CGPoint(x: 0, y: layer.bounds.height - margin))
                path.addLine(to: CGPoint(x: 0, y: margin))
            }
            if position.contains(.top) {
                path.move(to: CGPoint(x: margin, y: 0))
                path.addLine(to: CGPoint(x: layer.bounds.width - margin, y: 0))
            }
            if position.contains(.right) {
                path.move(to: CGPoint(x: layer.bounds.width, y: margin))
                path.addLine(to: CGPoint(x: layer.bounds.width,
                                         y: layer.bounds.height - margin))
            }
            if position.contains(.bottom) {
                path.move(to: CGPoint(x: layer.bounds.width - margin,
                                      y: layer.bounds.height))
                path.addLine(to: CGPoint(x: margin, y: layer.bounds.height))
            }
            if position.contains(.center){
                if let text = text, !text.isEmpty {
                    let label = UILabel()
                    label.text = text
                    label.textColor = textColor
                    label.font = textFont
                    label.textAlignment = .center
                    addSubview(label)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                    label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                    layoutIfNeeded()
                    path.move(to: CGPoint(x: layer.bounds.width * 0.5 - margin - label.frame.width * 0.5,
                                          y: layer.bounds.height * 0.5))
                    path.addLine(to: CGPoint(x: margin, y: layer.bounds.height * 0.5))
                    
                    path.move(to: CGPoint(x: layer.bounds.width - margin,
                                          y: layer.bounds.height * 0.5))
                    path.addLine(to: CGPoint(x: layer.bounds.width * 0.5 + margin + label.frame.width * 0.5,
                                             y: layer.bounds.height * 0.5))
                    
                } else {
                    path.move(to: CGPoint(x: layer.bounds.width - margin,
                                          y: layer.bounds.height * 0.5))
                    path.addLine(to: CGPoint(x: margin, y: layer.bounds.height * 0.5))
                }
            }
            shapeLayer.path = path
            layer.addSublayer(shapeLayer)
        }
    }
}
