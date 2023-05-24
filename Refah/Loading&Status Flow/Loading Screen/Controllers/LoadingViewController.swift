//
//  ViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/26/23.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            self.loadingView.layer.cornerRadius = 3
        }
    }
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            self.progressView.layer.cornerRadius = 3
        }
    }
    
    func loadTopImage() {
        let faraRefahTop: UIImage = UIImage(named: "FaraRefah_Top")!
        topImage?.image = faraRefahTop
    }
    
    func loadBottomImage() {
        let faraRefahBottom: UIImage = UIImage(named: "FaraRefah_Bottom")!
        bottomImage?.image = faraRefahBottom
    }
    
    func mockProgress() {
        for i in 1...4{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 1.0) {
                self.progressView.setProgress(0.25 * Float(i), animated: true)
                
                if i == 4 {
                    self.performSegue(withIdentifier: "customSegueId", sender: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTopImage()
        self.loadBottomImage()
        
        self.mockProgress()
    }
}
