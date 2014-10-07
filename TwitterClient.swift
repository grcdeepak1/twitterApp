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

    var loginCompletion : ((user: User?, error: NSError?) -> ())?
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: TWITTER_API_BASE_URL, consumerKey: TWITTER_API_CONSUMER_KEY, consumerSecret: TWITTER_API_CONSUMER_SECRET)
        }
        return Static.instance
    }
    
    func homeTimeLineWithParams(params: NSDictionary?,
        completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
            GET("1.1/statuses/home_timeline.json" ,
                parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    //println("timeline : \(response)")
                    var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                    completion(tweets: tweets, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting timeline")
                    //self.loginCompletion? (user: nil, error: error)
                    completion(tweets: nil, error: error)
            })
    }
    
    func mentionsWithParams(params: NSDictionary?,
        completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
            GET("1.1/statuses/user_timeline.json" ,
                parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    println("mentions : \(response)")
                    var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                    completion(tweets: tweets, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting timeline")
                    //self.loginCompletion? (user: nil, error: error)
                    completion(tweets: nil, error: error)
            })
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token and redirect to authorization page
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken : BDBOAuthToken!) -> Void in
            println("Got the request Token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
            }) { (error : NSError!) -> Void in
                println("Unable to get the request Token")
                self.loginCompletion? (user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
                println("Suceesfully got the Access Token")
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json" ,
                    parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        //println("User : \(response)")
                        var user = User(dictionary: response as NSDictionary)
                        User.currentUser = user
                        //println("User : \(user.name)")
                        self.loginCompletion? (user: user, error: nil)
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("error getting user")
                        self.loginCompletion? (user: nil, error: error)
                })
            
            }) { (error : NSError!) -> Void in
                println("Failed to recieve Access Token")
                self.loginCompletion? (user: nil, error: error)
        }
    }
    
    func favoriteWithID(tweet_id: String, callback: (response: AnyObject!, error: NSError!) -> Void) {
        sendPostRequest("1.1/favorites/create.json",
            parameters: [ "id": tweet_id ],
            callback: callback)
    }
    
    func unfavoriteWithID(tweet_id: String, callback: (response: AnyObject!, error: NSError!) -> Void) {
        sendPostRequest("1.1/favorites/destroy.json",
            parameters: [ "id": tweet_id ],
            callback: callback)
    }
    func tweet(status: String, callback: (response: AnyObject!, error: NSError!) -> Void) {
        sendPostRequest("1.1/statuses/update.json",
            parameters: [ "status": status ],
            callback: callback)
    }
    
    func retweet(tweet_id: String, callback: (response: AnyObject!, error: NSError!) -> Void) {
        sendPostRequest("1.1/statuses/retweet/\(tweet_id).json",
            parameters: nil,
            callback: callback)
    }
    func destroy(tweet_id: String, callback: (response: AnyObject!, error: NSError!) -> Void) {
        sendPostRequest("1.1/statuses/destroy/\(tweet_id).json",
            parameters: nil,
            callback: callback)
    }
    func getRetweets(tweet_id: String, callback: (response: AnyObject!, error: NSError!) -> Void) {
        sendPostRequest("1.1/statuses/retweets/\(tweet_id).json",
            parameters: nil,
            callback: callback)
    }
    
    func sendPostRequest(endpoint: String, parameters: [String: String]!, callback: (response: AnyObject!, error: NSError!) -> Void) {
        POST(endpoint,
            parameters: parameters,
            success: {
                // Success
                (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                callback(response: response, error: nil)
            },
            failure: {
                // Failure
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                callback(response: nil, error: error)
        })
    }
    
    func sendGetRequest(endpoint: String, parameters: [String: String]!, callback: (response: AnyObject!, error: NSError!) -> Void) {
        GET(endpoint,
            parameters: parameters,
            success: {
                // Success
                (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                callback(response: response, error: nil)
            },
            failure: {
                // Failure
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                callback(response: nil, error: error)
        })
    }
}
