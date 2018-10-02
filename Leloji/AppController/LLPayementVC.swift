//
//  LLPayementVC.swift
//  Leloji
//
//  Created by Ankleshwar on 17/09/18.
//  Copyright © 2018 Opiant tech Solutions Pvt. Ltd. All rights reserved.
//

//
//  ViewController.swift
//  Donate
//
//  Created by Ziad on 8/7/17.
//  Copyright © 2017 IntensifyStudio. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree

class LLPayementVC: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var donateButton: UIButton! {
        didSet {
            donateButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -42, bottom: 0, right: 0)
            donateButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
            donateButton.layer.cornerRadius = donateButton.bounds.midY
            donateButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var currencyLabel: UILabel! {
        didSet {
            currencyLabel.layer.cornerRadius = currencyLabel.bounds.midY
            currencyLabel.layer.masksToBounds = true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }
    
    func fetchClientToken() {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "http://ec2-13-126-37-79.ap-south-1.compute.amazonaws.com/api/payment/checkout")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            let clientToken = String(data: data!, encoding: String.Encoding.utf8)
            
            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    


    
 
    
    @IBAction func pay(_ sender: Any) {
     
        
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: toKinizationKey, request: request)
        { [unowned self] (controller, result, error) in
            
            if let error = error {
                self.show(message: error.localizedDescription)
                
            } else if (result?.isCancelled == true) {
                self.show(message: "Transaction Cancelled")
                
            } else if let nonce = result?.paymentMethod?.nonce, let amount = self.amountTextField.text {
               // self.sendRequestPaymentToServer(nonce: nonce, amount: amount)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func sendRequestPaymentToServer(nonce: String, amount: String) {
        activityIndicator.startAnimating()
        
        let paymentURL = URL(string: "https://your-server.example.com/payment-methods")!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(nonce)&amount=\(amount)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) -> Void in
            guard let data = data else {
                self?.show(message: error!.localizedDescription)
                return
            }
            
            guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let success = result?["success"] as? Bool, success == true else {
                self?.show(message: "Transaction failed. Please try again.")
                return
            }
            
            self?.show(message: "Successfully charged. Thanks So Much :)")
            }.resume()
    }
    
    func show(message: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


