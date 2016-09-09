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
    func doGet( _ addAuthHeader: Bool ,callBack: ((_ jsonResult: AnyObject, _ status: Bool, _ statusCode: Int) -> Void)?){
        
        //println("GET method invoked")
        var objRequest : NSMutableURLRequest = NSMutableURLRequest()
        
        var disJsonResult: NSDictionary!
        
        var strStatus = false
        
        var strStatusCode: Int!
        
       
        objRequest.url = URL(string: strURL)
        
        objRequest.httpMethod = "GET"
        objRequest.addValue("0", forHTTPHeaderField: "Content-Length")
        //objRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //objRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if (addAuthHeader) {
            
            objRequest.setValue(gObjUserBean.email, forHTTPHeaderField: "X-User-Email")
            
            objRequest.setValue(gObjUserBean.authentication_token, forHTTPHeaderField: "X-User-Token")
        }

        
        // sending AsynchronousRequest
        logger.log(LoggingLevel.info, message: "DoGet - doGet:\(strURL)")
        
        NSURLConnection.sendAsynchronousRequest(objRequest as URLRequest, queue: OperationQueue(), completionHandler:{ (response:URLResponse?, data: Data?, error: Error?) -> Void in
            
            if ((error) != nil)
            {
                logger.log(LoggingLevel.info, message: "error: \(error)")
                
                strStatus  = false
                
                var errorData: AutoreleasingUnsafeMutablePointer<NSError?>? = nil
                var errorBean:ErrorBean = ErrorBean()
                errorBean.description = "Empty Respsonse , Probable API key error"
                errorBean.exception   =  error.debugDescription
                errorBean.statusCode  =  401
                errorBean.reasonPhrase = "Check Status Code"
                
                //let dataToUse = NSJSONSerialization.JSONObjectWithData(errorBean as NSData, options:   NSJSONReadingOptions.AllowFragments, error: errorData) as! NSDictionary
                let JSONString = Mapper().toJSON(errorBean)
                
                callBack?(JSONString as AnyObject, strStatus, 401)
                
                return
                
            }
            logger.log(LoggingLevel.info, message: "\("response)")")
            
            if let responseUrl = response as? HTTPURLResponse
            {
                strStatusCode = responseUrl.statusCode
                
                // println(responseUrl)
                
                var error: AutoreleasingUnsafeMutablePointer<NSError?>? = nil
                
                logger.log(LoggingLevel.info, message: "\(strStatusCode)")
                
                var checkDAta: NSString  = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                
                do {
                    //JSON Parser
                    
                    disJsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                } catch _ {
                    /* TODO: Finish migration: handle the expression passed to error arg: error */
                    logger.log(LoggingLevel.info, message: "Error while Parsing JSON")
                    disJsonResult = ["Result" : "Empty",
                        "description"   : "",
                        
                        "exception"   : "",
                        "reasonPhrase": "",
                        
                        "statusCode"    : UNAUTHORIZED_REQUEST ]
                    
                    callBack?(disJsonResult, strStatus, 0)
                    return

                }
                
                if(strStatusCode < 400){
                    
                    strStatus  = true
                    
                    callBack?(disJsonResult, strStatus, strStatusCode)
                }
                    
                else{
                    strStatus  = false
                    
                    let dataToUse = (try! JSONSerialization.jsonObject(with: data!, options:   JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
                    
                    callBack?(dataToUse, strStatus, strStatusCode)
                    
                    logger.log(LoggingLevel.info, message: "\(dataToUse)")
                }
            }
            }
            
        )}
    
    /**
     *  Method call to the POST API
     */
    func doPost(_ strInputParamsJson: String?, addAuthHeader: Bool ,callBack: ((_ jsonResult: NSDictionary, _ status: Bool, _ statusCode: Int) -> Void)?){
        
        doUpdate(POST, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doPatch(_ strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((_ jsonResult: NSDictionary, _ status: Bool, _ statusCode: Int) -> Void)?){
        
        doUpdate(PATCH, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doDelete(_ strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((_ jsonResult: NSDictionary, _ status: Bool, _ statusCode: Int) -> Void)?){
        
        doUpdate(DELETE, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doPut(_ strInputParamsJson: String, addAuthHeader: Bool ,callBack: ((_ jsonResult: NSDictionary, _ status: Bool, _ statusCode: Int) -> Void)?){
        
        doUpdate(PUT, strInputParamsJson: strInputParamsJson, addAuthHeader: addAuthHeader, callBack: callBack)
    }
    
    func doUpdate(_ method: String, strInputParamsJson: String?, addAuthHeader: Bool ,callBack: ((_ jsonResult: NSDictionary, _ status: Bool, _ statusCode: Int) -> Void)?){
        
        var urlString = DEV_TARGET + strURL
        
        var objRequest : URLRequest = URLRequest(url: URL(string: urlString)!)
        
        var disJsonResult: NSDictionary!
        
        var strStatus = false
        
        var strStatusCode: Int!
        
        
        
//        if(gBoolSignOut){
//            urlString = DEV_TARGET_NO_API + strURL
//        }
        
        //objRequest.url = URL(string: urlString)
        
        objRequest.httpMethod = method
        
        objRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        objRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if (addAuthHeader) {
            
            objRequest.setValue(gObjUserBean.email, forHTTPHeaderField: "X-User-Email")
            
            objRequest.setValue(gObjUserBean.authentication_token, forHTTPHeaderField: "X-User-Token")
        }
        
        
        if (strInputParamsJson != nil && strInputParamsJson != "") {
            logger.log(LoggingLevel.info, message: "DoPost-InputParamJson\(strInputParamsJson)")
            
            objRequest.httpBody = strInputParamsJson!.data(using: String.Encoding.utf8)
        }
        
        // sending synchronousRequest
        logger.log(LoggingLevel.info, message: "\(objRequest)")
        
        let session = URLSession.shared
        
        // println("hold request proceeding")
        let task = session.dataTask(with: objRequest)
            
            { (data: Data?, response: URLResponse?, error: Error?) in
            
            if ((error) != nil)
            {
                logger.log(LoggingLevel.info, message: "error: \(error)")
                
                strStatus  = false
                
                let errorBean:ErrorBean = ErrorBean()
                errorBean.description = "Empty Respsonse , May be API key error"
                errorBean.exception   =  error.debugDescription
                errorBean.statusCode  =  401
                errorBean.reasonPhrase = "Check Status Code"
                
                //let dataToUse = NSJSONSerialization.JSONObjectWithData(errorBean as NSData, options:   NSJSONReadingOptions.AllowFragments, error: errorData) as! NSDictionary
                let JSONString = Mapper().toJSON(errorBean)
                
                callBack?(JSONString as NSDictionary, strStatus, errorBean.statusCode)
                
                return
            }
            
            logger.log(LoggingLevel.info, message: "\(response)")
            
            if let responseUrl = response as? HTTPURLResponse
            {
                strStatusCode = responseUrl.statusCode
                
                // println(responseUrl)
                
                let error:NSError?
                
                logger.log(LoggingLevel.info, message: "\(strStatusCode)")
                do{
                    //JSON Parser
                    disJsonResult =  try JSONSerialization.jsonObject(with: data!, options:[]) as? NSDictionary
                    
                    logger.log(LoggingLevel.info, message: "\(disJsonResult)")
                }catch{
                    logger.log(LoggingLevel.info, message: "Error while Parsing JSON")
                    disJsonResult = ["Result" : "Empty",
                                     "description"   : "",
                                     
                                     "exception"   : "",
                                     "reasonPhrase": "",
                                     
                                     "statusCode"    : UNAUTHORIZED_REQUEST ]
                    
                    callBack?(disJsonResult, strStatus, 0)
                    return
                    
                    
                }
                
                if(strStatusCode < 400){
                    
                    strStatus  = true
                    if(disJsonResult == nil)
                    {
                        
                        if NSString(data: data!, encoding: String.Encoding.utf8.rawValue) != nil
                        {
                            if let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSArray, let dictionary = json.firstObject as? NSDictionary {
                                logger.log(LoggingLevel.info, message: "\(dictionary)")
                                callBack?(dictionary, strStatus, strStatusCode)
                            } else {
                                
                                disJsonResult = ["Result" : "Empty"]
                                
                                callBack?(disJsonResult, strStatus, strStatusCode)
                                return
                            }
                            return
                        }
                        
                        disJsonResult = ["Result" : "Empty"]
                        
                        callBack?(disJsonResult, strStatus, strStatusCode)
                        return
                    }
                    for (key, value) in disJsonResult {
                        logger.log(LoggingLevel.info, message: "\(key) = \(value)")
                    }
                    
                    callBack?(disJsonResult, strStatus, strStatusCode)
                }
                else{
                    strStatus  = false
                    
                    let dataToUse = (try! JSONSerialization.jsonObject(with: data!, options:   JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
                    
                    callBack?(dataToUse, strStatus, strStatusCode)
                    
                    logger.log(LoggingLevel.info, message: "\(dataToUse)")
                }
            }
        }
        logger.log(LoggingLevel.info, message: "\(task)")
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
//            logger.log(LoggingLevel.INFO, message: "DoPost-InputParamJson\(strInputParamsJson)")
//            
//            objRequest.HTTPBody = strInputParamsJson.dataUsingEncoding(NSUTF8StringEncoding)
//        }
//        
//        // sending synchronousRequest
//        logger.log(LoggingLevel.INFO, message: objRequest)
//        
//        let session = NSURLSession.sharedSession()
//        
//        // println("hold request proceeding")
//        let task = session.dataTaskWithRequest(objRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
//            
//            if ((error) != nil)
//            {
//                logger.log(LoggingLevel.INFO, message: "error: \(error)")
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
//            logger.log(LoggingLevel.INFO, message: response)
//            
//            if let responseUrl = response as? NSHTTPURLResponse
//            {
//                strStatusCode = responseUrl.statusCode
//                
//                // println(responseUrl)
//                
//                let error:NSError?
//                
//                logger.log(LoggingLevel.INFO, message: strStatusCode)
//                do{
//                    //JSON Parser
//                    disJsonResult =  try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary
//                    
//                    logger.log(LoggingLevel.INFO, message: disJsonResult)
//                }catch{
//                    logger.log(LoggingLevel.INFO, message: "Error while Parsing JSON")
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
//                                logger.log(LoggingLevel.INFO, message: dictionary)
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
//                    logger.log(LoggingLevel.INFO, message: dataToUse)
//                }
//            }
//        }
//        task.resume()
//    }
    
    var dateFormatter = DateFormatter()
    func prettyConvertDateString(_ dateStr:String)->String{
        //The Server returns time in two formats
        //1. Event Details - "2016-05-28  9:56 AM EDT"
        //2. Create Event - "2016-04-07T13:02:16.247Z"
        //We will convert format 2 to format 1 here
        
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        
        let eventStartDate =  dateFormatter.date(from: dateStr)
        //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a 'EDT'"
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a zzz"
        
        return dateFormatter.string(from: eventStartDate!)

        
    }
}

