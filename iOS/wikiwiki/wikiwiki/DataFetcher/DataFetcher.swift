//
//  DataFetcher.swift
//  wikiwiki
//
//  Created by Brian Lin on 8/23/18.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol DataFetcherDelegateProtocol {
    func didReceiveData()
}

public class DataFetcher {
    
    private var URL = ""
    
    public var delegate: DataFetcherDelegateProtocol?
    
    public var data: JSON? {
        didSet {
            dataReceived()
        }
    }
    
    public init(url: String) {
        URL = url
    }
    
    public func getData() {
        let parameters: Parameters = [:]
        
        Alamofire.request(URL, method: .get, parameters: parameters).responseJSON { response in
            if let result = response.result.value, response.error == nil {
                self.data = JSON(result)
            } else {
                print(response.error as! String)
            }
        }
    }
    
    public func postData(dataToSend data: [String: String]) {
        Alamofire.request(URL, method: .get, parameters: data, encoding: URLEncoding(destination: .queryString), headers: nil).responseJSON { response in
            debugPrint(response)
        }
    }
    
    private func dataReceived() {
        delegate?.didReceiveData()
    }
}
