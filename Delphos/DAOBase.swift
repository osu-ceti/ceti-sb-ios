/**
 * FileName     :   DAOBase.swift
 * Created by   :   Venkat
 * Date Created :   5/18/2015
 * Description  :   Base Class to all HQRS DAO Objects.
 * All Copyrights reserved
 */

import UIKit
import Foundation
import ObjectMapper

/**
 * Base Class to all HQRS DAO Objects.
 */
class DAOBase: NSObject {
    
    var strURL: String!
    
    var intStatusCode: Int!
    
    //  Creating a Request
    /**
     * Method to call status code
     * @return true
     */
    func getIntStatusCode() -> Int {
        return intStatusCode;
    }
    
    
    /**
     * Method Adds API Key to the HTTP Connection Header.
     * Should be Overridden in Login DAO and Register as API Key is not Required
     */
    func doGet(addAuthHeader: Bool ,callBack: ((jsonResult: AnyObject, status: Bool, statusCode: Int) -> Void)?){
        
        //println("GET method invoked")
        var objRequest : NSMutableURLRequest = NSMutableURLRequest()
        
        var disJsonResult: AnyObject!
        
        var strStatus = false
        
        var strStatusCode: Int!
        
       
        objRequest.URL = NSURL(string: strURL)
        
        objRequest.HTTPMethod = "GET"
        objRequest.addValue("0", forHTTPHeaderField: "Content-Length")
        //objRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //objRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if (addAuthHeader) {
            
            objRequest.setValue(gObjUserBean.email, forHTTPHeaderField: "X-User-Email")
            
            objRequest.setValue(gObjUserBean.authentication_token, forHTTPHeaderField: "X-User-Token")
        }

        
        // sending AsynchronousRequest
        print("DoGet - doGet:\(strURL)")
        
        NSURLConnection.sendAsynchronousRequest(objRequest, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            if ((error) != nil)
            {
                print("error: \(error)")
                
                strStatus  = false
                
                var errorData: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var errorBean:ErrorBean = ErrorBean()
                errorBean.description = "Empty Respsonse , Probable API key error"
                errorBean.exception   =  error.debugDescription
                errorBean.statusCode  =  error!.code
                errorBean.reasonPhrase = "Check Status Code"
                
                //let dataToUse = NSJSONSerialization.JSONObjectWithData(errorBean as NSData, options:   NSJSONReadingOptions.AllowFragments, error: errorData) as! NSDictionary
                let JSONString = Mapper().toJSON(errorBean)
                
                callBack?(jsonResult: JSONString, status: strStatus, statusCode: 401)
                
                return
                
            }
            print(response)
            
            if let responseUrl = response as? NSHTTPURLResponse
            {
                strStatusCode = responseUrl.statusCode
                
                // println(responseUrl)
                
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                
                print(strStatusCode)
                
                var checkDAta: NSString  = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                
                do {
                    //JSON Parser
                    
                    disJsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)
                } catch _ {
                    /* TODO: Finish migration: handle the expression passed to error arg: error */
                    print("Error while Parsing JSON")
                    disJsonResult = ["Result" : "Empty",
                        "description"   : "",
                        
                        "exception"   : "",
                        "reasonPhrase": "",
                        
                        "statusCode"    : 0 ]
                    
                    callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: 0)
                    return

                }
                
                if(strStatusCode < 400){
                    
                    strStatus  = true
                    
                    callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
                }
                    
                else{
                    strStatus  = false
                    
                    let dataToUse = (try! NSJSONSerialization.JSONObjectWithData(data!, options:   NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                    
                    callBack?(jsonResult: dataToUse, status: strStatus, statusCode: strStatusCode)
                    
                    print(dataToUse)
                }
            }
            }
        )}
    
    /**
     *  Method call to the POST API
     */
    func doPost(strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((jsonResult: NSDictionary, status: Bool, statusCode: Int) -> Void)?){
        
        doUpdate(POST, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doPatch(strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((jsonResult: NSDictionary, status: Bool, statusCode: Int) -> Void)?){
        
        doUpdate(PATCH, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doDelete(strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((jsonResult: NSDictionary, status: Bool, statusCode: Int) -> Void)?){
        
        doUpdate(DELETE, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doPut(strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((jsonResult: NSDictionary, status: Bool, statusCode: Int) -> Void)?){
        
        doUpdate(PUT, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doUpdate(method: String, strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((jsonResult: NSDictionary, status: Bool, statusCode: Int) -> Void)?){
        
        let objRequest : NSMutableURLRequest = NSMutableURLRequest()
        
        var disJsonResult: NSDictionary!
        
        var strStatus = false
        
        var strStatusCode: Int!
        
        var urlString = DEV_TARGET + strURL
        
//        if(gBoolSignOut){
//            urlString = DEV_TARGET_NO_API + strURL
//        }
        
        objRequest.URL = NSURL(string: urlString)
        
        objRequest.HTTPMethod = method
        
        objRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        objRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if (addAuthHeader) {
            
            objRequest.setValue(gObjUserBean.email, forHTTPHeaderField: "X-User-Email")
            
            objRequest.setValue(gObjUserBean.authentication_token, forHTTPHeaderField: "X-User-Token")
        }
        
        
        if strInputParamsJson != "" {
            print("DoPost-InputParamJson\(strInputParamsJson)")
            
            objRequest.HTTPBody = strInputParamsJson.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        // sending synchronousRequest
        print(objRequest)
        
        let session = NSURLSession.sharedSession()
        
        // println("hold request proceeding")
        let task = session.dataTaskWithRequest(objRequest)
            
            { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            if ((error) != nil)
            {
                print("error: \(error)")
                
                strStatus  = false
                
                let errorBean:ErrorBean = ErrorBean()
                errorBean.description = "Empty Respsonse , Probable API key error"
                errorBean.exception   =  error.debugDescription
                errorBean.statusCode  =  error!.code
                errorBean.reasonPhrase = "Check Status Code"
                
                //let dataToUse = NSJSONSerialization.JSONObjectWithData(errorBean as NSData, options:   NSJSONReadingOptions.AllowFragments, error: errorData) as! NSDictionary
                let JSONString = Mapper().toJSON(errorBean)
                
                callBack?(jsonResult: JSONString, status: strStatus, statusCode: 401)
                
                return
            }
            
            print(response)
            
            if let responseUrl = response as? NSHTTPURLResponse
            {
                strStatusCode = responseUrl.statusCode
                
                // println(responseUrl)
                
                let error:NSError?
                
                print(strStatusCode)
                do{
                    //JSON Parser
                    disJsonResult =  try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary
                    
                    print(disJsonResult)
                }catch{
                    print("Error while Parsing JSON")
                    disJsonResult = ["Result" : "Empty",
                                     "description"   : "",
                                     
                                     "exception"   : "",
                                     "reasonPhrase": "",
                                     
                                     "statusCode"    : 0 ]
                    
                    callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: 0)
                    return
                    
                    
                }
                
                if(strStatusCode < 400){
                    
                    strStatus  = true
                    if(disJsonResult == nil)
                    {
                        
                        if NSString(data: data!, encoding: NSUTF8StringEncoding) != nil
                        {
                            if let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray, let dictionary = json.firstObject as? NSDictionary {
                                print(dictionary)
                                callBack?(jsonResult: dictionary, status: strStatus, statusCode: strStatusCode)
                            } else {
                                
                                disJsonResult = ["Result" : "Empty"]
                                
                                callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
                                return
                            }
                            return
                        }
                        
                        disJsonResult = ["Result" : "Empty"]
                        
                        callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
                        return
                    }
                    for (key, value) in disJsonResult {
                        print("\(key) = \(value)")
                    }
                    
                    callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
                }
                else{
                    strStatus  = false
                    
                    let dataToUse = (try! NSJSONSerialization.JSONObjectWithData(data!, options:   NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                    
                    callBack?(jsonResult: dataToUse, status: strStatus, statusCode: strStatusCode)
                    
                    print(dataToUse)
                }
            }
        }
        print(task)
        task.resume()
    }
    
//    func doDelete(strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((jsonResult: NSDictionary, status: Bool, statusCode: Int) -> Void)?){
//        
//        
//        let objRequest : NSMutableURLRequest = NSMutableURLRequest()
//        
//        var disJsonResult: NSDictionary!
//        
//        var strStatus = false
//        
//        var strStatusCode: Int!
//        
//        
//        objRequest.URL = NSURL(string: DEV_TARGET+strURL)
//        
//        objRequest.HTTPMethod = "DELETE"
//        
//        objRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        if (addAuthHeader) {
//            
//            objRequest.setValue(gObjUserBean.email, forHTTPHeaderField: "X-User-Email")
//            
//            objRequest.setValue(gObjUserBean.authentication_token, forHTTPHeaderField: "X-User-Token")
//        }
//        
//        
//        if strInputParamsJson != "" {
//            print("DoPost-InputParamJson\(strInputParamsJson)")
//            
//            objRequest.HTTPBody = strInputParamsJson.dataUsingEncoding(NSUTF8StringEncoding)
//        }
//        
//        // sending synchronousRequest
//        print(objRequest)
//        
//        let session = NSURLSession.sharedSession()
//        
//        // println("hold request proceeding")
//        let task = session.dataTaskWithRequest(objRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
//            
//            if ((error) != nil)
//            {
//                print("error: \(error)")
//                
//                strStatus  = false
//                
//                let errorBean:ErrorBean = ErrorBean()
//                errorBean.description = "Empty Respsonse , Probable API key error"
//                errorBean.exception   =  error.debugDescription
//                errorBean.statusCode  =  error!.code
//                errorBean.reasonPhrase = "Check Status Code"
//                
//                //let dataToUse = NSJSONSerialization.JSONObjectWithData(errorBean as NSData, options:   NSJSONReadingOptions.AllowFragments, error: errorData) as! NSDictionary
//                let JSONString = Mapper().toJSON(errorBean)
//                
//                callBack?(jsonResult: JSONString, status: strStatus, statusCode: 401)
//                
//                return
//            }
//            
//            print(response)
//            
//            if let responseUrl = response as? NSHTTPURLResponse
//            {
//                strStatusCode = responseUrl.statusCode
//                
//                // println(responseUrl)
//                
//                let error:NSError?
//                
//                print(strStatusCode)
//                do{
//                    //JSON Parser
//                    disJsonResult =  try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary
//                    
//                    print(disJsonResult)
//                }catch{
//                    print("Error while Parsing JSON")
//                    disJsonResult = ["Result" : "Empty",
//                                     "description"   : "",
//                                     
//                                     "exception"   : "",
//                                     "reasonPhrase": "",
//                                     
//                                     "statusCode"    : 0 ]
//                    
//                    callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: 0)
//                    return
//                    
//                    
//                }
//                
//                if(strStatusCode < 400){
//                    
//                    strStatus  = true
//                    if(disJsonResult == nil)
//                    {
//                        
//                        if NSString(data: data!, encoding: NSUTF8StringEncoding) != nil
//                        {
//                            if let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray, let dictionary = json.firstObject as? NSDictionary {
//                                print(dictionary)
//                                callBack?(jsonResult: dictionary, status: strStatus, statusCode: strStatusCode)
//                            } else {
//                                
//                                disJsonResult = ["Result" : "Empty"]
//                                
//                                callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
//                                return
//                            }
//                            return
//                        }
//                        
//                        disJsonResult = ["Result" : "Empty"]
//                        
//                        callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
//                        return
//                    }
//                    
//                    callBack?(jsonResult: disJsonResult, status: strStatus, statusCode: strStatusCode)
//                }
//                else{
//                    strStatus  = false
//                    
//                    let dataToUse = (try! NSJSONSerialization.JSONObjectWithData(data!, options:   NSJSONReadingOptions.AllowFragments)) as! NSDictionary
//                    
//                    callBack?(jsonResult: dataToUse, status: strStatus, statusCode: strStatusCode)
//                    
//                    print(dataToUse)
//                }
//            }
//        }
//        task.resume()
//    }
    
    var dateFormatter = NSDateFormatter()
    func prettyConvertDateString(dateStr:String)->String{
        //The Server returns time in two formats
        //1. Event Details - "2016-05-28  9:56 AM EDT"
        //2. Create Event - "2016-04-07T13:02:16.247Z"
        //We will convert format 2 to format 1 here
        
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        
        let eventStartDate =  dateFormatter.dateFromString(dateStr)
        //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a 'EDT'"
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a zzz"
        
        return dateFormatter.stringFromDate(eventStartDate!)

        
    }
}

