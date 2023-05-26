//
//  ViewWithProgressViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/25/23.
//

import UIKit

protocol LaunchViewWithProgressViewProtocol where Self: UIView {
    var progressView: UIProgressView { get }
    
    func setProgressOfProgressView(_ progress: Float, animated: Bool)
}
