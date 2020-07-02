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
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.nameLabel.text = self.tweet.user.name;
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"%@", self.tweet.user.screenName];;
    
    self.createdAtLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    self.retweetedCountLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.favoritedCountLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    
    [self updateRetweetButtonImage];
    [self updateFavorButtonImage];

    self.profilePicture.image = nil;
    if (self.tweet.user.profileImage != nil) {
        NSString *profileImageBlurry = self.tweet.user.profileImage;
        NSString *profileImageUnBlurry = [profileImageBlurry stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        NSURL *profileImageURL = [NSURL URLWithString:profileImageUnBlurry];
        [self.profilePicture setImageWithURL:profileImageURL];
    }
}

-(void)updateRetweetButtonImage {
    UIImage *retweetedImage = [[UIImage alloc] init];
    if (self.tweet.retweeted)
        retweetedImage = [UIImage imageNamed:@"retweet-icon-green.png"];
    else
        retweetedImage = [UIImage imageNamed:@"retweet-icon.png"];
    [self.retweetedButton setImage:retweetedImage forState:UIControlStateNormal];
}

-(void)updateFavorButtonImage {
    UIImage *favoritedImage = [[UIImage alloc] init];
    if (self.tweet.favorited)
        favoritedImage = [UIImage imageNamed:@"favor-icon-red.png"];
    else
        favoritedImage = [UIImage imageNamed:@"favor-icon.png"];
    [self.favoritedButton setImage:favoritedImage forState:UIControlStateNormal];
}

- (IBAction)didTapRetweet:(id)sender {
    
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self updateRetweetButtonImage];
    self.retweetedCountLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
}

- (IBAction)didTapFavorite:(id)sender {
    
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self updateFavorButtonImage];
    self.favoritedCountLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
}

@end
