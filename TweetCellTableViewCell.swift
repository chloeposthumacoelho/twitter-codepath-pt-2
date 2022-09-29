//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Chloe Posthuma Coelho on 9/24/22.
//  Copyright © 2022 Dan. All rights reserved.
//


import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var retweeted:Bool = false
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error in retweeting \(error)")
        })
        
        
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false;
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true;
        }
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setFavourite(_ isFavorited:Bool) {
        
        favorited = isFavorited
        
        if (favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        
        if(toBeFavorited) {
            TwitterAPICaller.client?.favorite(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (error) in
                print("Cannot set to favorited: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavorite(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (error) in
                print("Cannot set to unfavorited: \(error)")
            })
        }
        
        
    }
}
