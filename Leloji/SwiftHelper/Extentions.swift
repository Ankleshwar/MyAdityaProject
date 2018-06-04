//
//  Extentions.swift
//  TestExtension
//
//  Created by Opiant on 26/12/17.
//  Copyright © 2017 Opiant. All rights reserved.
//

import Foundation
import UIKit



public extension String {
 
    
    func getAWSBlankString() -> String {
        if self == "*blank"
        {
            return "";
        }
        return self
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func stringWithFloat(float f: Float) -> String {
        let string = "\(f)"
        return string
    }
    
    func stringWithInt(int f: Int) -> String {
        let string = "\(f)"
        return string
    }
    
    func getCurrencyFormattedString(withCurrencySymbol currencySymbol:String) -> String {
        
        let priceNumber = NumberFormatter().number(from:self)
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.decimalSeparator = ","
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = 0
        return formatter.string(from:priceNumber!)! // $123"
        
    }
    
    func getDateString(fromFormat:String, toFormat:String) -> String
    {
        
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat;
        let date:Date = formatter.date(from: self)!
        
        let toFomatter = DateFormatter()
        toFomatter.dateFormat = toFormat;
        return toFomatter.string(from:date)
        
    }
    
    
    
    
    
}





var filePath: String {

    let manager = FileManager.default

    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
    
   
    return (url!.appendingPathComponent("Data").path)
}


public extension Date {
    public  func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from:date)
    }
    
    public static func dateFromISOString(string: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)!
    }
    
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "dd EEEE MMM yyyy"
        return formatter
    }()
    
    
    var iso8601: String {
        
        
        return Date.iso8601Formatter.string(from: self)
    }
    
   
    var dayAfter : String
    {
        let date = Date()
        return ISOStringFromDate(date: date)
    }
   
 

    
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var dayAfterTomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    
}

public extension UIColor {
    

    

    
 public  func colorWith(r: Int, g: Int, b: Int) -> UIColor{
    return UIColor(red: CGFloat((Float(r) / 255.0)), green: CGFloat((Float(g) / 255.0)), blue: CGFloat((Float(b) / 255.0)), alpha: 1.0)
}


    func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public extension UIView {
    
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
    
}

public extension Calendar {

    public func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)?.count ?? 0
    }
}


public extension NSDictionary{
    
    func nonNullObject(forKey string: String) -> Any {
        let object = self[string]
        if (object is NSNull) {
            return ""
        }
        else {
            return object ?? 0
        }
    }
    
    func nonNullNumber(forKey string: String) -> Any {
        let object = self[string]
        if object == nil {
            return -1
        }
        else if (object is NSNull) {
            return -1
        }
        else {
            return object ?? 0
        }
        
    }
}

public extension NSMutableArray {
    func object(with index: Int) -> Any {
        var object = ""
        if count > index {
            object = self[index] as? String ?? ""
        }
        return object
    }
    
    func reverse() {
        if count == 0 {
            return
        }
        var i: Int = 0
        var j: Int = count - 1
        while i < j {
            swap(&self[i], &self[j])
            i += 1
            j -= 1
        }
    }
}


extension UIApplication {
   
}


