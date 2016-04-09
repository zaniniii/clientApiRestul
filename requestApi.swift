//
//  requestApi.swift
//  testeApi
//
//  Created by Luiz Carlos Zanini on 09/04/16.
//  Copyright © 2016 Za9. All rights reserved.
//

import UIKit

class requestApi: NSObject {

    // Url Base da API
    var baseUrl = "<URL>"


    private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
        request.HTTPMethod = method

        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

        session.dataTaskWithRequest(request) { (data, response, error) -> Void in


            if let data = data {
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])

                if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                    completion(success: true, object: json)
                } else {
                    completion(success: false, object: json)
                }
            }
            }.resume()
    }

    func post(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", completion: completion)
    }

    func put(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "PUT", completion: completion)
    }

    func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }

    func delete(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "DELETE", completion: completion)
    }


    func clientURLRequest(endpoint: String, token: String? = nil, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.baseUrl + endpoint)!)

        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                let escapedValue = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                paramString += escapedKey! + "=" + escapedValue! + "&"
            }

            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)

            print(paramString)
        }


        if token != nil{
            request.addValue(token!, forHTTPHeaderField: "X-Access-Token")
            //request.addValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }

        return request
    }


}
