//
//  NewAccountCreatedViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit
import PDFKit

class NewAccountCreatedViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var pdfURL: URL?
    
    @IBAction func downloadButtonIsPressed(_ sender: UIButton) {
//        self.pdfView.isHidden = false
        
//        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
//            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
//                pdfView.displayMode = .singlePageContinuous
//                pdfView.autoScales = true
//                pdfView.displayDirection = .vertical
//                pdfView.document = pdfDocument
//            }
//        }
        
        // --------------
        
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else { return }
                
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
                
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        
        self.shadowView.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadButton.layer.cornerRadius = 20
        
        self.shadowView.isHidden = true
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

extension NewAccountCreatedViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.shadowView.isHidden = true
            
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "GreenJungle")!, message: "دانلود با موفقیت انجام شد.", style: UIAlertController.Style.alert, okActionTitle: "باشه", okActionCompletion: { _ in
                guard let document = PDFDocument(url: self.pdfURL!) else {
                    self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "امکان نمایش فایل دانلود‌شده وجود ندارد.")
                    return
                }
            
                self.pdfView.isHidden = false
                self.pdfView.document = document
            })
        }
    }
}
