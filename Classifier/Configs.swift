/*-------------------------------
 
 - Classifier -
 
 @author thfrknyldz
 Created by CarbonCode Technology @2019
 All Rights reserved
 
 -------------------------------*/


import Foundation
import UIKit
import AVFoundation
import CoreLocation




// IMPORTANT: Replace the red string below with the new name you'll give to this app
let APP_NAME = "Classifier"


// IMPORTANT: REPLACE THE RED STRING BELOW WITH YOUR OWN BANNER UNIT ID YOU'LL GET FROM  http://apps.admob.com
let ADMOB_BANNER_UNIT_ID = "ca-app-pub-5377978058610989/4088872997"


// YOU CAN CHANGE THE STRING BELOW INTO THE CURRENCY YOU WANT
let CURRENCY = "$"


// THIS IS THE RED MAIN COLOR OF THIS APP
let MAIN_COLOR = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
let SECOND_COLOR = UIColor(red: 246/255, green: 210/255, blue: 88/255, alpha: 1.0)





// REPLACE THE RED STRINGS BELOW WITH YOUR OWN TEXTS FOR THE EACH WIZARD'S PAGE
let wizardLabels = [
    "SHARE YOUR AD EASILY\n\nYou can upload your ad easily and share it for sale, for rent, for exchange or for gift.",
    
    "VIEW ADS BY CATEGORIES\n\nYou can search and share ads in any category",
    
    "CHAT WITH OTHER USERS\n\nThanks to advance chat module, you can chat with other users.",
]



// YOU CAN CHANGE THE AD REPORT OPTIONS BELOW AS YOU WISH
let reportAdOptions = [
    "Prohibited item",
    "Conterfeit",
    "Wrong category",
    "Keyword spam",
    "Repeated post",
    "Nudity/pornography/mature content",
    "Hateful speech/blackmail",
]


// YOU CAN CHANGE THE USER REPORT OPTIONS BELOW AS YOU WISH
let reportUserOptions = [
    "Selling counterfeit items",
    "Selling prohibited items",
    "Items wrongly categorized",
    "Nudity/pornography/mature content",
    "Keyword spammer",
    "Hateful speech/blackmail",
    "Suspected fraudster",
    "No-show on meetup",
    "Backed out of deal",
    "Touting",
    "Spamming",
]



// HUD View extension
let hudView = UIView(frame: CGRect(x:0, y:0, width:120, height: 120))
let label = UILabel()
let indicatorView = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:80, height:80))
extension UIViewController {
    
    var homecellWidth: CGFloat {
        
        return view.frame.width
    }
    
    var adscellWidth: CGFloat {
        
        return (view.frame.width - 20) / 2
    }
    
    var explorecellWidth: CGFloat {
        
        return (view.frame.width - 4) / 3
    }
    
    
    func showHUD(_ mess:String) {
        hudView.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        //hudView.backgroundColor = MAIN_COLOR
        hudView.backgroundColor = SECOND_COLOR
        hudView.alpha = 1.0
        hudView.layer.cornerRadius = 8
        
        indicatorView.center = CGPoint(x: hudView.frame.size.width/2, y: hudView.frame.size.height/2)
        indicatorView.activityIndicatorViewStyle = .gray
        hudView.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.addSubview(hudView)
        
        label.frame = CGRect(x: 0, y: 90, width: 120, height: 20)
        label.font = UIFont(name: "Gerbera W04 Light", size: 15)
        label.text = mess
        label.textAlignment = .center
        label.textColor = UIColor.black
        hudView.addSubview(label)
    }
    
    func hideHUD() {
        hudView.removeFromSuperview()
        label.removeFromSuperview()
    }
    
    func simpleAlert(_ mess:String) {
        let alert = UIAlertController(title: APP_NAME, message: mess, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // SHOW LOGIN ALERT
    func showLoginAlert(_ mess:String) {
        let alert = UIAlertController(title: APP_NAME,
                                      message: mess,
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Login", style: .default, handler: { (action) -> Void in
            let aVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "Wizard") as! Wizard
            self.present(aVC, animated: true, completion: nil)
            
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}

/* Global Variables */
var distanceInMiles:Double = 50
var sortBy = "Newest"
var exploresortBy = "Most Popular"
var type = "All"
var exploretype = "All"

var selectedCategory = "All"
var selectedSubCategory = "All"
var selectedCity = "All"

//var chosenLocation:CLLocation?



// MARK: - METHOD TO CREATE A THUMBNAIL OF YOUR VIDEO
func createVideoThumbnail(_ url:URL) -> UIImage? {
    let asset = AVAsset(url: url)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.appliesPreferredTrackTransform = true
    var time = asset.duration
    time.value = min(time.value, 2)
    do { let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: imageRef)
    } catch let error as NSError {
        print("Image generation failed with error \(error)")
        return nil
    }
}


// MARK: - EXTENSION TO RESIZE A UIIMAGE
extension UIViewController {
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}



// EXTENSION TO FORMAT LARGE NUMBERS INTO K OR M (like 1.1M, 2.5K)
extension Int {
    var abbreviated: String {
        let abbrev = "KMBTPE"
        return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(self)
    }
}



// EXTENSION TO SHOW TIME AGO DATES
extension UIViewController {
    func timeAgoSinceDate(_ date:Date,currentDate:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 h ago"
            } else {
                return "An h ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 min ago"
            } else {
                return "A min ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds"
        } else {
            return "Just now"
        }
        
    }
    
}





