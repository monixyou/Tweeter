//
//  TweetCell.m
//  twitter
//
//  Created by Monica Bui on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.createdAtLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    self.retweetedCountLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.favoritedCountLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    
    self.profilePicture.image = nil;
    if (self.tweet.user.profileImage != nil) {
        NSString *profileImageBlurry = self.tweet.user.profileImage;
        NSString *profileImageUnBlurry = [profileImageBlurry stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        NSURL *profileImageURL = [NSURL URLWithString:profileImageUnBlurry];
        [self.profilePicture setImageWithURL:profileImageURL];
    }
}

@end
