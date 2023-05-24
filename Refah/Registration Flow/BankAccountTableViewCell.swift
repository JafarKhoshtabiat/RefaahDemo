//
//  BankAccountTableViewCell.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit

class BankAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var rowNumberLabel: UILabel!
    @IBOutlet weak var bankAccountNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRowNumber(rowNumber: Int) {
        self.rowNumberLabel.text = self.englishOneDigitToPersianMap["\(rowNumber)"]
    }
    
    func setBankAccountNumber(bankAccountNumber: String) {
        self.bankAccountNumberLabel.text = bankAccountNumber
    }
    
    let englishOneDigitToPersianMap = [
        "1" : "۱",
        "2" : "۲",
        "3" : "۳",
        "4" : "۴",
        "5" : "۵",
        "6" : "۶",
        "7" : "۷",
        "8" : "۸",
        "9" : "۹"
    ]
}
