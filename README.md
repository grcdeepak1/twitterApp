iOS Twitter App 
============================

Implemented User Stories
------------------------

- [x] User can sign in to Twitter using OAuth 1.0a login flow.
- [x] User can view 20 tweets from their home timeline.
- [x] The current signed in user will be persisted across restarts.
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. Model Classes were enhanced.
- [x] User can pull to refresh.
- [x] User can compose a new tweet by tapping on a New button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] Optional: When composing, you should have a countdown in the upper right for the tweet limit.
- [x] Optional: Retweeting and favoriting increment the retweet and favorite count.
- [x] Optional: Unfavorite will decrement the retweet and favorite count.
- [x] Optional: Replies should be prefixed with the username and the Reply_id should be set when posting the tweet
- [ ] Optional: User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] Optional: After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.

Time Taken : 20 Hrs

Twitter Redux
===============

Hamburger menu
--------------
- [x] Dragging anywhere in the view will reveal the sliding menu.
- [x] The menu includes links to your profile, the home timeline, and the mentions view.
- [x] Contains the user header view

Profile page
------------
- [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] Optional : Implement the paging view for the user description.
- [ ] Optional : As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
- [ ] Optional : Pulling down the profile page should blur and resize the header image.

Home Timeline
-------------
- [x] Tapping on a user image will bring up that user's profile page

Screen Capture
--------------


![twitter App](twitterApp.gif)
![twitter App] (twitterAppRedux.gif)
