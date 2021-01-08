//
//  ApiClient.swift
//  OleZone
//
//  Created by Mohammed Khaled (Sob7y) on 8/14/17.
//  Copyright © 2017 Ole.Zone. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiClient {
    
    static var language = Defaults.sharedInstance.applicationLanguage?.rawValue
    
    static func setLanguage(language:String){
        self.language = language
    }
    
    static func fetch(url:String, httpMethod:HTTPMethod, parameters:Parameters,headers:HTTPHeaders, apiCallBack:ApiCallBack){
        var newHeaders = headers
        newHeaders["X_Api_Key"] = Constant.keys.API_KEY
        newHeaders["X_Api_Language"] = language
        newHeaders["Content_Type"] = "application/json"
        
        Alamofire.request(ApiUrls.base_url + url, method: httpMethod, parameters: parameters, encoding: URLEncoding.default
            , headers: newHeaders).responseJSON { response in
            switch response.result {
            case .success:
                let baseResponse = Mapper<BaseResponse>().map(JSONObject: response.result.value)
                print("\(String(describing: baseResponse))")
                apiCallBack.onSuccess(response: response.result.value! as AnyObject)
                break
            case .failure(let error):
                apiCallBack.onFailure(error: ApiError(errorMessage: error.localizedDescription, errorCode: 404, errors: []))
                break
            }
        }
    }
    
    static func fetchWithJson(url:String, httpMethod:HTTPMethod, parameters: Parameters,headers:HTTPHeaders, apiCallBack:ApiCallBack){
        var newHeaders = headers
        newHeaders["X_Api_Key"] = Constant.keys.API_KEY
        newHeaders["X_Api_Language"] = language
        newHeaders["Content_Type"] = "application/json"
        
        Alamofire.request(ApiUrls.base_url + url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.prettyPrinted
            , headers: newHeaders).responseJSON { response in
                switch response.result {
                case .success:
                    let baseResponse = Mapper<BaseResponse>().map(JSONObject: response.result.value)
                    print("\(String(describing: baseResponse))")
                    apiCallBack.onSuccess(response: response.result.value! as AnyObject)
                    break
                case .failure(let error):
                    apiCallBack.onFailure(error: ApiError(errorMessage: error.localizedDescription, errorCode: 404, errors: []))
                    break
                }
        }
    }
    
    static func uploadImage(fileData:Data, url:String,httpMethod:HTTPMethod,parameters:Parameters,headers:HTTPHeaders,apiCallBack:ApiCallBack){
        
        let token = (UserDefaults.standard.object(forKey: Constant.keys.USER_TOKEN)) as? String
        let userToken = "Bearer " + token!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileData, withName: "image", fileName: "image.png", mimeType: "image/png")
            
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        },to: ApiUrls.base_url + url,
          method: .post,
          headers: ["X_Api_Key": Constant.keys.API_KEY, "Authorization":userToken],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            //Print progress
                            print("progress = \(progress)")
                        })
                        
                        upload.responseJSON { (JSON) in
                            DispatchQueue.main.async(execute: {
                                //Show Alert in UI
                                print(JSON)
                                print(JSON.data!)
                                print(JSON.result)
                                print(JSON.result.value!)
                                print("Avatar uploaded");
                                
                                switch JSON.result {
                                case .success:
                                    apiCallBack.onSuccess(response: JSON.result.value as AnyObject)
                                    break
                                case .failure(let error):
                                    apiCallBack.onFailure(error: ApiError(errorMessage: error.localizedDescription, errorCode: 404, errors: []))
                                    break
                                }
                                
                            })
                        }
                        
                    case .failure(let encodingError):
                        print("error:\(encodingError.localizedDescription)")
                        apiCallBack.onFailure(error: ApiError(errorMessage: encodingError.localizedDescription, errorCode: 404, errors: []))
                    }
        })
    }
    
}


