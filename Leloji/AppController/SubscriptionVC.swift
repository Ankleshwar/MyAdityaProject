//
//  SubscriptionVC.swift
//  Leloji
//
//  Created by Ankleshwar on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//Share your personal referral code with your friends and get REWARDED for nextsubscription..!!

import UIKit
import SVProgressHUD
import BraintreeDropIn
import Braintree


class SubscriptionVC: BaseViewController {
    var strToken = String()
     var strAmount = String()
    
    @IBOutlet weak var btnVoucher: UIButton!
    @IBOutlet var flowingMenuTransitionManager: FlowingMenuTransitionManager!
    
    @IBOutlet weak var btnSubscription: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flowingMenuTransitionManager.setInteractivePresentationView(view)
        flowingMenuTransitionManager.delegate = self
        
        self.getToken()
    }


    override func viewWillAppear(_ animated: Bool) {
        self.view.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.isHidden = true
    }

    @IBAction func clickToMenu(_ sender: Any) {
        
        setController()
        
        
    }
    
    @IBAction func clickToSubscription(_ sender: Any) {
        
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: self.strToken, request: request)
        { [unowned self] (controller, result, error) in
            
            if let error = error {
                ECSAlert().showAlert(message: error.localizedDescription, controller: self)
                
            } else if (result?.isCancelled == true) {
                ECSAlert().showAlert(message: "Transaction Cancelled", controller: self)
                
            } else if let nonce = result?.paymentMethod?.nonce {
                
                
                
                
                    print("Nonce\(result?.paymentMethod?.nonce)")
                    print(result?.paymentMethod?.type)
                print(result?.paymentMethod?.localizedDescription)
                guard let cardNonce = result?.paymentMethod as? BTCardNonce else {
                   
                    return
                }
                guard let PaymentCardType = result?.paymentMethod?.type  else {
                    return
                }
                guard let description = result?.paymentMethod?.localizedDescription  else {
                    return
                }
              
                
//                print(cardNonce.binData)
//                print(cardNonce.cardNetwork)
                print(cardNonce.lastTwo ?? "")
                print(cardNonce.type ?? "" )
//                print(cardNonce.threeDSecureInfo)
                
                let dic = [
                
                    "nonce": nonce,
                    "type": PaymentCardType,
                    "description":description,
                    "details":[
                        "cardType": cardNonce.type ?? "",
                        "lastTwo": cardNonce.lastTwo ?? "",
                        
                    ],
                    "binData":[
                    
                    ]
                
                    ] as [String : Any]
                
                
                self.sendRequestPaymentToServer(nonce: dic, amount: self.strAmount)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    
    
    func sendRequestPaymentToServer(nonce: [String : Any], amount: String) {
        
        print(nonce)
        
    let    dic = [
            "payment_method_payload":nonce,
            "amount": amount,
            "voucher_code": "Test12",
            "gateway": "Braintree"
        ] as [String : Any]
        
       SVProgressHUD.show()
        
        
        ServiceClass().sendPaymentNonch(strUrl:"payment/checkout", prama: dic , header: (self.appUserObject?.token ?? "") ) { (result)  in
            switch result {
            case .Error(let error):
                do {
                    ECSAlert().showAlert(message: (error.localizedDescription), controller: self)
                    SVProgressHUD.dismiss()
                }
            case .Success(let json):
                print(json)
                SVProgressHUD.dismiss()
                
            }
            
            
        }
      
    }
    
    
    
    func getToken(){
        SVProgressHUD.show()
        
        
     
        
        ServiceClass().getBrainTreeToken(strUrl:"payment/checkout", prama: [:] , header: (self.appUserObject?.token ?? "") ) { (result)  in
            switch result {
            case .Error(let error):
                do {
                    ECSAlert().showAlert(message: (error.localizedDescription), controller: self)
                    SVProgressHUD.dismiss()
                }
            case .Success(let json):
                let obj = Subscription(fromJson: json)
                let str  = "Subscribe to our monthly plan for \(obj.membershipPlan.amount!) \(obj.membershipPlan.currency!)"
                self.btnSubscription.setTitle(str, for: .normal)
                self.strToken = obj.braintreeToken
                let amount = (obj.membershipPlan?.amount)!
                self.strAmount = String(amount)
                SVProgressHUD.dismiss()
                
            }
            
            
        }
    }
    
    
    func getDiscount(strCode: String){
        SVProgressHUD.show()
        
        
        let dic = [
        
            "voucher_code":strCode
       
            
            ]
        
        
        ServiceClass().getDiscountedData(strUrl:"payment/apply_voucher", prama: dic , header: (self.appUserObject?.token ?? "") ) { (result)  in
            switch result {
            case .Error(let error):
                do {
                    ECSAlert().showAlert(message: (error.localizedDescription), controller: self)
                    SVProgressHUD.dismiss()
                }
            case .Success(let json):
                let obj = Voucher(fromJson: json)
               
               
                 let str  = "Subscribe to our monthly plan for \(obj.amount!) \(obj.currency!)"
                self.btnSubscription.setTitle(str, for: .normal)
             //   let amount = json["amount"] as! Int
                self.strAmount = String(obj.amount)
                print(json)
                self.btnVoucher.isEnabled = false
                SVProgressHUD.dismiss()
                
            }
            
            
        }
    }
    
    
    func show(message: String) {
        DispatchQueue.main.async {
          
            
            let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func clickToReferalCode(_ sender: Any) {
        let alert = UIAlertController(title: "Referral Code", message: "Enter a code", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let textCode = textField?.text {
                self.getDiscount(strCode: textCode)
            }
            
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    

}
extension SubscriptionVC: FlowingMenuDelegate{
    func setController() {
        
        
        
        let vc = LeftDrawer(nibName: "LeftDrawer", bundle: nil)
        vc.view.frame = self.view.bounds
        vc.transitioningDelegate = flowingMenuTransitionManager
        present(vc, animated: true, completion: nil)
        
    }
    
    
    func colorOfElasticShapeInFlowingMenu(_ flowingMenu: FlowingMenuTransitionManager) -> UIColor? {
        return #colorLiteral(red: 0.01176470588, green: 0.9921568627, blue: 0.9843137255, alpha: 1)
    }
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        setController()
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
