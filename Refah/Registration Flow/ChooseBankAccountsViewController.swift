//
//  ChooseAccountsViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit

class ChooseBankAccountsViewController: UIViewController {

    @IBOutlet weak var chooseBankAccountsTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var chooseBankAccountsTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
         self.performSegue(withIdentifier: "accountCreatedSegue", sender: nil)
    }
    
    var numberOfRows: Int = 0
    var bankAccounts: [String] = []
    
    func generateRandom10DigitString() -> String {
        return "\(Int.random(in: 1_000_000_000...9_999_999_999))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberOfRows = Int.random(in: 1..<10)
        for _ in 0..<self.numberOfRows {
            self.bankAccounts.append(self.generateRandom10DigitString())
        }
        
        self.chooseBankAccountsTableView.register(UINib(nibName: "BankAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "BankAccountTableViewCell")
        
        self.chooseBankAccountsTableViewHeightConstraint.constant = CGFloat(25 * self.numberOfRows)
        self.chooseBankAccountsTableView.layer.cornerRadius = 20
        
        self.chooseBankAccountsTableView.delegate = self
        self.chooseBankAccountsTableView.dataSource = self
        self.chooseBankAccountsTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        
        self.nextButton.layer.cornerRadius = 20
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

extension ChooseBankAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankAccountTableViewCell", for: indexPath) as! BankAccountTableViewCell
        cell.setRowNumber(rowNumber: indexPath.row + 1)
        cell.setBankAccountNumber(bankAccountNumber: self.bankAccounts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let indexes = tableView.indexPathsForSelectedRows else {return nil}
        if indexes.count > 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
