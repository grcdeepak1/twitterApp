//
//  TwitterClient.swift
//  twitterApp
//
//  Created by Deepak on 9/27/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit
let TWITTER_API_CONSUMER_KEY = "9zVFEKgKCVsj2kR57TH7Kavqe"
let TWITTER_API_CONSUMER_SECRET = "duiofpcQ32pZGCYwts447WKV15QmgXQvkwB4KV4BJnwsDXi3Mb"
let TWITTER_API_TOKEN = "116844089-93VBvdAw78KJysZdYoWAzcgIDzIWPHdGfF5sQppU"
let TWITTER_API_TOKEN_SECRET = "wh7hbfVkx0V9z4923ClXRS2nOsmFTHEF8lJ7toPCSri5s"

let TWITTER_API_OAUTH1_AUTHENTICATE_URL = NSURL(string: "https://api.twitter.com/oauth/authenticate")
let TWITTER_API_OAUTH2_TOKEN_URL        = NSURL(string: "https://api.twitter.com/oauth2/token")
let TWITTER_API_USER_TIMELINE_URL       = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
let TWITTER_API_BASE_URL                = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: TWITTER_API_BASE_URL, consumerKey: TWITTER_API_CONSUMER_KEY, consumerSecret: TWITTER_API_CONSUMER_SECRET)
        }
        return Static.instance
    }
   
}
