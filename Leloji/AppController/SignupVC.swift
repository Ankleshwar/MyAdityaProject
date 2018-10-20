//
//  SignupVC.swift
//  VoyMate
//
//  Created by Opiant on 23/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import UIKit
import SVProgressHUD
import TextFieldEffects
import Crashlytics
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation





class SignupVC: BaseViewController {
   
    @IBOutlet weak var txtConfirmPass: HoshiTextField!
    @IBOutlet weak var txtCountryCode: HoshiTextField!
    @IBOutlet weak var txtState: HoshiTextField!
    @IBOutlet weak var txtLastName: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtFirstName: HoshiTextField!
    var strName: String = ""
    var strEmail: String = ""
    var strId : String = ""
     var strType : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.txtFirstName.text = strName
            self.txtEmail.text = strName
        
        
    }


    @IBAction func clickToBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // self.txtEmail.textRect(forBounds: self.txtEmail.bounds)
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }


    @IBAction func clickToSignUp(_ sender: Any) {
         //Crashlytics.sharedInstance().crash()
        let strEmail : String
        strEmail = txtEmail.text!

        if txtFirstName.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Name", controller: self)
        }else if txtEmail.text?.count == 0{
            ECSAlert().showAlert(message: "Please Enter valid Email", controller: self)
        }else if strEmail.isValidEmail() == false {
             ECSAlert().showAlert(message: "Please Enter valid Email", controller: self)
        }
            
        else if txtPassword.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Password", controller: self)
        }
        else if txtConfirmPass.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Confirm Password", controller: self)
        }
            
        else if isEqual (txtPassword.text == txtConfirmPass.text) {
            ECSAlert().showAlert(message: "Please Match  Your Password", controller: self)
        }
        else{
            callSignUpServiec()
        }
        
//        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
//        self.present(viewController, animated: true, completion: nil)
        
        print("value added")
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        
        return transition
    }
    
    
    
    
    
    func callSignUpServiec(){
        
    
        let dic = [ "firstName": self.txtFirstName.text ?? "",
                   "lastName":self.txtLastName.text ?? "",
                   "password": self.txtPassword.text ?? "",
                   "countryCode": self.txtCountryCode.text ?? "",
                   "email": self.txtEmail.text ?? "",
                   "state":self.txtState.text ?? "",
                   "signupType": strType
            ] as [String : Any]
        
         SVProgressHUD.show()
        ServiceClass().signUpDetails(strUrl:"auth/signup", param: dic ) { error , dicData  in
            
            if dicData["status"] as! Bool == true {

               
                    
                
                self.appUserObject = AppUserObject.instance(from: dicData)
                self.appUserObject?.token = dicData["auth_token"] as! String
                self.appUserObject?.saveToUserDefault()
                UserDefaults.standard.set(1, forKey: "isLogin")
                UserDefaults.standard.synchronize()
                let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
                self.present(viewController, animated: true, completion: nil)
                        
                    
                
               
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                if let users = dicData["error"] as? [String : Any] {
              
                    for errData in (users as? [String : Any])!{
                        print(errData)
                      //  let msg = 
                      //  ECSAlert().showAlert(message: msg, controller: self)
                    }
                        
                    
                        
                    
                }
                
                SVProgressHUD.dismiss()
                
                
                
            }
            
        }
    }
    
    
    
    
    
    
    
}
    
    
    
    


class MyCustomTextField : UITextField {
    var leftMargin : CGFloat = 10.0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += leftMargin
        return newBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += leftMargin
        return newBounds
    }
}

extension SignupVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Print place info to the console.
        print("Place name: \(place.name)")
        //        print("Place address: \(place.formattedAddress)")
        //        print("Place attributions: \(place.attributions)")
        let lat = place.coordinate.latitude
        let lon = place.coordinate.longitude
//        self.lat = String(lat)
//        self.lng = String(lon)
        
        print("lat lon",lat,lon)
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print(street)
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                self.txtState.text = city
                print(city)
                
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                self.txtCountryCode.text = zip
                print(zip)
                 self.dismiss(animated: true, completion: nil)
            }
            // Country
            if let country = placeMark.country {
                print(country)
            }
        })
        
      
       
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}


extension SignupVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
        // self.moveTextField(textField: textField, moveDistance: 50, up: true)
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        
        if textField == self.txtCountryCode {
            
            textField.resignFirstResponder()
            present(autocompleteController, animated: true, completion: nil)
            
        }
        else if textField == self.txtState {
            
            textField.resignFirstResponder()
            present(autocompleteController, animated: true, completion: nil)
        }
        
    }
    
    
}
