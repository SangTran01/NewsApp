//
//  Article.swift
//  NewsApp
//
//  Created by Sang Tran on 2022-10-22.
//

import Foundation

struct ResponseObject: Codable
{
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Source: Codable
{
    var id: String?
    var name: String?
}

struct Article: Codable
{
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage:String?
    var publishedAt:String?
    var content: String?
}
