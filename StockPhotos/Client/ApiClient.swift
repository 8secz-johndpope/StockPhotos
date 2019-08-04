//
//  ApiClient.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 3.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
        
    func fetchImages(_ page: Int, _ perPage: Int, _ completion: @escaping (_ data: Welcome?, _ error: Error?) -> Void) {
        let parameters: Parameters = ["page": page, "per_page": perPage]
        let urlString = "\(Constants.Endpoint.shutterstockApi)images/search"
        
        Alamofire.request(urlString,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString),
                          headers: getHeaderData()).response { response in
                        
                            self.setResult(response, completion)
        }
        
    }
    
    private func setResult(_ response: DefaultDataResponse, _ completion: @escaping (_ data: Welcome?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let photoData = try decoder.decode(Welcome.self, from: response.data!)
            completion(photoData, response.error)
        } catch {
            completion(nil, error)
        }
    }
    
    private func getHeaderData() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(getCredentialData())",
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        return headers
    }
    
    private func getCredentialData() -> String {
        let credentialData = "\(Constants.Credential.key):\(Constants.Credential.secret)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        return credentialData.base64EncodedString()
    }
    
}
