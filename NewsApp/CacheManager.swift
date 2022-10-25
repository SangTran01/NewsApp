//
//  CacheManager.swift
//  NewsApp
//
//  Created by Sang Tran on 2022-10-25.
//

import Foundation

class CacheManager
{
    static var ImageDictionary = [String: Data]()
    
    static func Save(_ url: String,_ data: Data)
    {
        if (ImageDictionary[url] == nil)
        {
            ImageDictionary[url] = data
        }
    }
    
    static func Get(_ url:String) -> Data?
    {
        return ImageDictionary[url]
    }
}
