//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Sang Tran on 2022-10-23.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var ArticleLabel: UILabel!
    @IBOutlet weak var ArticleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        // Clean up the cell before displaying the next article
        ArticleImageView.image = nil
        ArticleLabel.text = ""
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        ArticleLabel.text = articleToDisplay!.title
        
        // Download and display the image
        
        // Check that the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Create url string
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the cachemanager before downloading any image data
        if let imageData = CacheManager.Get(urlString) {

            // There is image data, set the imageview and return
            ArticleImageView.image = UIImage(data: imageData)
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check that the url isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there were no errors
            if error == nil && data != nil {
                
                // Save the data into cache
                CacheManager.Save(urlString, data!)
                
                // Check if the url string that the data task went off to download matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.ArticleImageView.image = UIImage(data: data!)
                    }
                    
                }
                
            } // End if
            
        } // End data task
        
        // Kick off the datatask
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
