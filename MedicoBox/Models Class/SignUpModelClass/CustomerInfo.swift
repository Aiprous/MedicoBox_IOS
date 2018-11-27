//
//  CustomerInfo.swift
//  MedicoBox
//
//  Created by SBC on 27/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class CustomerInfo: NSObject {

        
   class func dataTask_GET(_ path: URL, method: HTTPMethod, param: Dictionary<String, Any>, compilationBlock:@escaping (_ result: Result<Any, NSError> ) -> Void){
        
       
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let JSON):
                compilationBlock(.success(JSON))
                break
            case .failure(_):
                let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "Server Not Responding"]);
                compilationBlock(.failure(customError))
                break
            }
        }
    }
    
    class func dataTask_PUT(_ path: URL, method: HTTPMethod, param: Dictionary<String, Any>, compilationBlock:@escaping (_ result: Result<Any, NSError> ) -> Void){
        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(path, method: .put, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let JSON):
                compilationBlock(.success(JSON))
                break
            case .failure(_):
                let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "Server Not Responding"]);
                compilationBlock(.failure(customError))
                break
            }
        }
    }
    
    class func dataTask_POST(_ path: URL, method: HTTPMethod, param: Dictionary<String, Any>, compilationBlock:@escaping (_ result: Result<Any, NSError> ) -> Void){
        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(path, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let JSON):
                compilationBlock(.success(JSON))
                break
            case .failure(_):
                let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "Server Not Responding"]);
                compilationBlock(.failure(customError))
                break
            }
        }
    }
    
    class func dataTask_DELETE(_ path: URL, method: HTTPMethod, param: Dictionary<String, Any>, compilationBlock:@escaping (_ result: Result<Any, NSError> ) -> Void){
        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(path, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let JSON):
                compilationBlock(.success(JSON))
                break
            case .failure(_):
                let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "Server Not Responding"]);
                compilationBlock(.failure(customError))
                break
            }
        }
    }
}
