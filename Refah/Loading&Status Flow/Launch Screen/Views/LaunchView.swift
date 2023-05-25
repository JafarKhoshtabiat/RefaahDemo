//
//  LaunchView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/25/23.
//

import UIKit

class LaunchView: UIView {
    let progressView: UIProgressView = UIProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        let topImageView = UIImageView()
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topImageView)
        let topImageViewTopConstraint = NSLayoutConstraint(item: topImageView, attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .top,
                                                           multiplier: 1, constant: 0)
        let topImageViewRightConstraint = NSLayoutConstraint(item: topImageView, attribute: .right,
                                                             relatedBy: .equal,
                                                             toItem: self, attribute: .right,
                                                             multiplier: 1, constant: 0)
        let topImageViewHeightConstraint = NSLayoutConstraint(item: topImageView, attribute: .height,
                                                              relatedBy: .equal,
                                                              toItem: self, attribute: .height,
                                                              multiplier: 0.7, constant: 0)
        let topImageViewLeftConstraint = NSLayoutConstraint(item: topImageView, attribute: .left,
                                                               relatedBy: .equal,
                                                               toItem: self, attribute: .left,
                                                               multiplier: 1, constant: 0)
        self.addConstraints([topImageViewTopConstraint, topImageViewRightConstraint, topImageViewHeightConstraint, topImageViewLeftConstraint])
        if let topImage = UIImage(named: "FaraRefah_Top") {
            topImageView.image = topImage
        }
        
        let bottomImageView = UIImageView()
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomImageView)
        let bottomImageViewTopConstraint = NSLayoutConstraint(item: bottomImageView, attribute: .top,
                                                              relatedBy: .equal,
                                                              toItem: topImageView, attribute: .bottom,
                                                              multiplier: 1, constant: 0)
        let bottomImageViewRightConstraint = NSLayoutConstraint(item: bottomImageView, attribute: .right,
                                                                relatedBy: .equal,
                                                                toItem: self, attribute: .right,
                                                                multiplier: 1, constant: 0)
        let bottomImageViewHeightConstraint = NSLayoutConstraint(item: bottomImageView, attribute: .height,
                                                                 relatedBy: .equal,
                                                                 toItem: self, attribute: .height,
                                                                 multiplier: 0.3, constant: 0)
        let bottomImageViewLeftConstraint = NSLayoutConstraint(item: bottomImageView, attribute: .left,
                                                               relatedBy: .equal,
                                                               toItem: self, attribute: .left,
                                                               multiplier: 1, constant: 0)
        self.addConstraints([bottomImageViewTopConstraint, bottomImageViewRightConstraint, bottomImageViewHeightConstraint, bottomImageViewLeftConstraint])
        if let bottomImage = UIImage(named: "FaraRefah_Bottom") {
            bottomImageView.image = bottomImage
        }
        
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor.juneberry
        progressView.trackTintColor = UIColor.unicornSilver
        progressView.layer.cornerRadius = 3
        self.addSubview(self.progressView)
        let progressViewTopConstraint = NSLayoutConstraint(item: self.progressView, attribute: .centerY,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .centerY,
                                                           multiplier: 1.4, constant: 0)
        let progressViewRightConstraint = NSLayoutConstraint(item: self.progressView, attribute: .right,
                                                             relatedBy: .equal,
                                                             toItem: self, attribute: .right,
                                                             multiplier: 1, constant: -40)
        let progressViewHeightConstraint = NSLayoutConstraint(item: self.progressView, attribute: .height,
                                                              relatedBy: .equal,
                                                              toItem: self, attribute: .height,
                                                              multiplier: 0, constant: 5)
        let progressViewLeftConstraint = NSLayoutConstraint(item: self.progressView, attribute: .centerX,
                                                            relatedBy: .equal,
                                                            toItem: self, attribute: .centerX,
                                                            multiplier: 1, constant: 0)
        self.addConstraints([progressViewTopConstraint, progressViewRightConstraint, progressViewHeightConstraint, progressViewLeftConstraint])
    }
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension LaunchView: ViewWithProgressViewProtocol {
    func setProgressOfProgressView(_ progress: Float, animated: Bool) {
        self.progressView.setProgress(progress, animated: animated)
    }
}
