//
//  ViewController.swift
//  NewsApp
//
//  Created by Sang Tran on 2022-10-22.
//

import UIKit

class ViewController: UIViewController, ArticlesProtocol, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticlesModel()
    var articles = [Article]()
    var resObj: ResponseObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        model.delegate = self
        model.getTopArticlesByCountry()
        tableView.delegate = self
        tableView.dataSource = self
    }

    //MARK: Articles Protocol Methods
    func articlesReceived(_ resObj: ResponseObject) {
        if let articles = resObj.articles {
            self.articles = articles
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: table view protocol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        cell.ArticleImageView.image = nil
        cell.ArticleLabel.text = ""
        
        let article = articles[indexPath.row]
        
        cell.displayArticle(article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        print(article.title ?? "None")
    }
}

