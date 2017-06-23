//
//  BaseController.swift
//  Delphos
//
//  Created by lingaadm on 8/12/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
class BaseController:UIViewController {
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    //Loader funvtion
    func showOverlay(_ view: UIView) {
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(white: 0xFFFFFF, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.black
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    func isCheckNilOrNot(_ labelData:String,labelText:String){
        
        if(labelData != DelphosStrings.EMPTY_STRING){
        
        }
        else{
        
        }
    
    
    }
    func showAlert(_ objCurrentController: UIViewController, strMessage: String) {
        
        DispatchQueue.main.async(execute: {
            let alertView = UIAlertController(title: DelphosStrings.EMPTY_STRING, message: strMessage, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            objCurrentController.present(alertView, animated: true, completion: nil)
            
            
        })
    }
    func extractDay(fromDate: String) -> String{
        
        return fromDate.substring(to: fromDate.index(fromDate.startIndex, offsetBy: 10))
        

    }
    func getTimeZone(from: String)->String{
        //"2017-10-27"
        let day = extractDay(fromDate: from)
        
        let dFormat = DateFormatter()
        dFormat.dateFormat = gDateFormat
        dFormat.locale = Locale(identifier: "en_US_POSIX")
        let targetDate = dFormat.date(from: day)
        let isDST = NSTimeZone.local.isDaylightSavingTime(for: targetDate!)
        //let calTimezone = Calendar.current.timeZone.abbreviation()!
        
        if(isDST == true){
            return "EDT"
        }
        else{
            return "EST"
        }
    }
}
