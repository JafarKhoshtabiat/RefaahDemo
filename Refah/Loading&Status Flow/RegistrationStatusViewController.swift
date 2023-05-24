//
//  RegistrationStatusViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/26/23.
//

import UIKit

class RegistrationStatusViewController: UIViewController {

    @IBOutlet weak var refahLogoName: UIImageView!
    
    @IBOutlet weak var newRegistrationButton: UIButton!
    @IBOutlet weak var alreadyRegisteredButton: UIButton!
    
    func loadImage() {
        let refahLogoName: UIImage = UIImage(named: "Refah_Logo_Name")!
        self.refahLogoName?.image = refahLogoName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadImage()
        
        self.newRegistrationButton.layer.cornerRadius = 20
        self.alreadyRegisteredButton.layer.borderColor = CGColor(red: 0, green: 43/255, blue: 102/255, alpha: 1)
        self.alreadyRegisteredButton.layer.borderWidth = 2
        self.alreadyRegisteredButton.layer.cornerRadius = 20
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
