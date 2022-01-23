//
//  KeyCenter.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 1/9/22.
//

import Foundation

struct KeyCenter {
    static let AppId: String = "" //改写appid

    // assign token to nil if you have not enabled app certificate
    static var TokenPUBLISHER: String?
    static var TokenSUBSCRIBER: String?
    
    static func getPUBLISHERToken(){
         let session: URLSession = {
                let config = URLSessionConfiguration.default
                return URLSession(configuration: config)
            }()
        
        var components = URLComponents(string: "")! //改写后端网址
        let queryItems = [URLQueryItem(name: "uid", value: "1")]
        components.queryItems = queryItems
        let url = components.url!
        let request = URLRequest(url: url)
            let task = session.dataTask(with: request) {
                (data, response, error) in
                if let data = data {
                    if let token = String(data: data,encoding: .utf8)
                    {
                        KeyCenter.TokenPUBLISHER = token
                        print(token)
                    }
            
        }
         else if let requestError = error {
                    print("Error fetching interesting photos: \(requestError)")
        } else {
                    print("Unexpected error with the request")
                }
        }
            task.resume()
        }
    
    static func getSUBSCRIBERToken(){
         let session: URLSession = {
                let config = URLSessionConfiguration.default
                return URLSession(configuration: config)
            }()
        
        var components = URLComponents(string: "")!//改写后端网址
        let queryItems = [URLQueryItem(name: "uid", value: "2")]
        components.queryItems = queryItems
        let url = components.url!
        let request = URLRequest(url: url)
            let task = session.dataTask(with: request) {
                (data, response, error) in
                if let data = data {
                    if let token = String(data: data,encoding: .utf8)
                    {
                        KeyCenter.TokenSUBSCRIBER = token
                        print(token)
                    }
            
        }
         else if let requestError = error {
                    print("Error fetching interesting photos: \(requestError)")
        } else {
                    print("Unexpected error with the request")
                }
        }
            task.resume()
        }
        
    }

