//
//  AUiChannelView.swift
//  AUiGiftToast
//
//  Created by zhaoyongqiang on 2023/4/11.
//

import UIKit

enum AUiChannelViewAnimationType {
    case idle       //闲置
    case animating      //正在执行动画
    case willEnd        //将要结束动画(在移动动画结束，正在悬浮3s的时候)
    case endAnimating   //结束动画（悬浮3s结束，开始执行结束动画）
}

class AUiChannelView: UIView {
    //动画执行状态
    var status: AUiChannelViewAnimationType = .idle
    //当前的礼物数目
    var currentNum: Int = 0
    //还需要执行礼物动画的次数
    var cacheNum: Int = 0
    var finishedCallBackBlock: ((AUiChannelView)->Void)?
    
    var giftEntity: AUiGiveGiftEntity? {
        didSet{
            guard let entity = giftEntity else {return}
            status = .animating
            currentNum = 0
            cacheNum = 0
//            avatarImageView.image = UIImage(named: entity.senderURL)
            senderLabel.text = entity.senderName
            giftDescLabel.text = entity.giftName
//            giftImageView.image = UIImage(named: entity.giftURL)
            showAnimation()
        }
    }
    
    // MARK: 控件属性
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.35)
        view.layer.cornerRadius = 28
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var senderLabel: UILabel = {
        let label = UILabel()
        label.text = "user"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var giftDescLabel: UILabel = {
        let label = UILabel()
        label.text = "送出了火箭"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var giftImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "airplane.departure"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var numLabel: AUiGiftNumLabel = {
        let label = AUiGiftNumLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(avatarImageView)
        bgView.addSubview(senderLabel)
        bgView.addSubview(giftDescLabel)
        bgView.addSubview(giftImageView)
        addSubview(numLabel)
        
        bgView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        avatarImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -8).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        senderLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8).isActive = true
        senderLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 2).isActive = true
        
        giftDescLabel.leadingAnchor.constraint(equalTo: senderLabel.leadingAnchor).isActive = true
        giftDescLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -2).isActive = true
        
        giftImageView.leadingAnchor.constraint(equalTo: giftDescLabel.trailingAnchor, constant: 22).isActive = true
        giftImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        giftImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16).isActive = true
        
        numLabel.leadingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 10).isActive = true
        numLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
    }
}


// MARK: - 连击逻辑
extension AUiChannelView {
    func addOneToCache() {
        if status == .willEnd {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            showNumLabelAnimation()
        } else {
            cacheNum += 1
        }
    }
}

// MARK: - 动画
extension AUiChannelView {
    private func showAnimation() {
        numLabel.text = "  X1  "
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
            self.frame.origin.x = 0
        }) { (isFinished) in
            self.showNumLabelAnimation()
        }
    }
    
    private func showNumLabelAnimation() {
        status = .animating         //注意，这里每次递归都进行状态初始化
                                    //主要为了防止在状态置为willEnd延时3秒后执行showEndAnimation的时候，再次addOneToCache导致状态出问题
                                    //主要是想说明，动画肯定是在主线程执行的，动画的执行有0.25秒的持续过程，这个地方如果不做好相关状态的判断，会出现bug
        currentNum += 1
        numLabel.text = "  X\(currentNum)  "
        numLabel.showNumAnimation { [weak self] in
            guard let cacheNum = self?.cacheNum else {return}
            if cacheNum > 0 {
                self?.cacheNum -= 1
                self?.showNumLabelAnimation()
            } else {
                if self?.giftEntity != nil {
                    self?.status = .willEnd
                    self?.perform(#selector(self?.showEndAnimation), with: nil, afterDelay: 3)
                    
                } else {
                    self?.showEndAnimation()
                }
            }
        }
    }
    
    @objc
    private func showEndAnimation() {
        if status != .willEnd { return }
        status = .endAnimating
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0
        }) { isFinished in
            self.status = .idle
            self.currentNum = 0
            self.cacheNum = 0
            self.giftEntity = nil
            self.frame.origin.x = -self.frame.width
            guard let finishedBlock = self.finishedCallBackBlock else {return}
            finishedBlock(self)
        }
    }
}
