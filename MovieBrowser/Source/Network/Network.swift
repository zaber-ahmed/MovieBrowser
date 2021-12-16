//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class Network: NSObject {
    
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    
    override init() {

    }
    
    //
    // https://api.themoviedb.org/3/search/movie?api_key=<<API_KEY>>&language=en-US&page=1&include_adult=false&query=uu
    
    public func getSearchResults(queryString query: String, fetchCompleted:@escaping (_ data:Data?,_ response:URLResponse?, _ error:Error?) -> Void)
    {
        debugPrint("Query: \(query)")
        
        let link = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&page=1&include_adult=false&query=\(query)"
        let apiUrl = URL(string: link)!
        debugPrint("Link: \(link)")
        
        let configuration = URLSessionConfiguration.default
        if #available(iOS 11.0, *) {
            configuration.waitsForConnectivity = false
        }
        configuration.timeoutIntervalForRequest = 30.0
        let session = URLSession(configuration:configuration)
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "get"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            fetchCompleted(data, response, error)
        }
        task.resume()
    }

}

protocol searchResultDelegate {
    func loginAPIResponse(response: SearchResults?)
    func didFailWithError(error:Error)
}

struct ApiParser{
    
    var delegate: searchResultDelegate?
    
    public func parse(data: Data?,response: URLResponse?, error:Error?)
    {
        if error != nil
        {
            print(error!)
            self.delegate?.didFailWithError(error: error!)
            return
        }
        if let safeData = data
        {
            if let response = parseJSON(safeData)
            {
                self.delegate?.loginAPIResponse(response: response)
            }
        }
    }
    
    func parseJSON(_ responseData: Data) -> SearchResults?
    {
        let decoder = JSONDecoder()
        do{
            let model = try decoder.decode(SearchResults.self, from: responseData)
            return model
        } catch {
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
