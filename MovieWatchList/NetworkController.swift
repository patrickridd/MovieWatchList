//
//  NetworkController.swift
//  MovieWatchList
//
//  Created by Patrick Ridd on 10/13/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
        
        
    }
    
    static func performRequestForURL(url: NSURL, httpMethod: HTTPMethod, urlParameters: [String: String]? = nil, body: NSData? = nil, completion: ((_ data: NSData?, _ error: NSError?) ->Void)?) {
        
        let requestUrl = urlFromParameters(url: url, urlParameters: urlParameters)
        let request = NSMutableURLRequest(url: requestUrl as URL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body as Data?
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let completion = completion {
                completion(data as NSData?, error as NSError?)
            }
        }
        dataTask.resume()
        
    }
    
    static func urlFromParameters(url: NSURL, urlParameters: [String: String]?) -> NSURL {
        let components = NSURLComponents(url: url as URL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = urlParameters?.flatMap({(NSURLQueryItem(name: $0.0, value: $0.1) as URLQueryItem)})
        
        if let url = components?.url {
            return url as NSURL
        } else {
            fatalError("URL optional is nil")
        }
    }
}
