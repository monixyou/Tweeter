//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Monica Bui on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetedButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetedCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoritedButton;
@property (weak, nonatomic) IBOutlet UILabel *favoritedCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    // UI Adjustments
    self.replyTextView.layer.borderWidth = 1.0f;
    self.replyTextView.layer.borderColor = [[UIColor grayColor] CGColor];

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

- (IBAction)didTapReply:(id)sender {
    NSString *reply_text = [NSString stringWithFormat:@"Replying to @%@\n%@", self.tweet.user.screenName, self.replyTextView.text];
    
    [[APIManager shared] replyStatusWithText:reply_text reply_status_id:self.tweet.idStr completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error replying to tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully replied with the following Tweet: %@", tweet.text);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
