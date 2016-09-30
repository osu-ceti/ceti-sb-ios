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
        
        if(labelData != ""){
        
        }
        else{
        
        }
    
    
    }
    
}
