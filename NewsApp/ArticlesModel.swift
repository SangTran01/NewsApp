//
//  ArticlesModel.swift
//  NewsApp
//
//  Created by Sang Tran on 2022-10-22.
//

import Foundation

protocol ArticlesProtocol
{
    func articlesReceived(_ resObj: ResponseObject)
}

class ArticlesModel
{
    var baseUrl = "https://newsapi.org/v2/"
    var apiKey = "89439b1a897c4b4da2ab0ec9b18266d7";
    
    var delegate: ArticlesProtocol?
    
    func getTopArticlesByCountry()
    {
        let queryItems = [URLQueryItem(name: "apiKey", value: apiKey), URLQueryItem(name: "country", value: "ca")
        , URLQueryItem(name: "category", value: "business")]
        var urlComps = URLComponents(string: baseUrl + "top-headlines")!
        urlComps.queryItems = queryItems
        
        if let url = urlComps.url {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if (data != nil && error == nil)
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        
                        let resObject = try decoder.decode(ResponseObject.self, from: data!)
                        
                        //delegate let know complete
                        self.delegate?.articlesReceived(resObject)
                    } catch
                    {
                        print(error)
                    }
                } else
                {
                    print("error getting data from url")
                }
            }
            
            task.resume()
        }
    }
}
