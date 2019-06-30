//
//  FlickerService.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation

protocol FilckerServiceProtocol {
    func fetchPhotos(query: String , page: UInt, handler: @escaping (Error?, PhotoModel?) -> Void)
}

class FilckerService: FilckerServiceProtocol {
    var session : URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func fetchPhotos(query: String , page: UInt, handler: @escaping (Error?, PhotoModel?) -> Void) {
        let httpClient: HttpClientProtocol = HttpClient(session: self.session)
        guard let url = URL(string: FilckerService.getFlickrURL(query : query, page: page)) else {
            let error = NSError(domain: "com.ios.kushal", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Url"])
            handler(error, nil)
            return
        }
        httpClient.get(url: url) { (data, error) in
            if error != nil {
                handler(error, nil)
                return
            }
            let decoder = JSONDecoder()
            guard let data = data, let photoModel = try? decoder.decode(PhotoModel.self, from: data) else {
                let error = NSError(domain: "com.ios.kushal", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to parse response"])
                handler(error, nil)
                return
            }
            
            handler(nil,photoModel)
        }
    }
    
    class func getFlickrURL(query : String, page : UInt) -> String {
        
        return "\(Constants.Api.kBaseFlickrUrl)&text=\(query)&api_key=\(Constants.Api.kApiKey)&page=\(page)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
}
