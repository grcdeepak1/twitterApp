//
//  Tweet.swift
//  twitterApp
//
//  Created by Deepak on 9/27/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt : NSDate?
    var dictionary: NSDictionary
    var id: NSNumber?
    var id_str: String?
    var retweet_count: NSNumber?
    var favorite_count: NSNumber?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        id = dictionary["id"] as? NSNumber
        id_str = dictionary["id_str"] as? String
        retweet_count = dictionary["retweet_count"] as? NSNumber
        favorite_count = dictionary["favorite_count"] as? NSNumber
        //println(dictionary)        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
