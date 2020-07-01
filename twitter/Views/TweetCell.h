//
//  TweetCell.h
//  twitter
//
//  Created by Monica Bui on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (weak, nonatomic) IBOutlet UIButton *retweetedButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetedCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoritedButton;
@property (weak, nonatomic) IBOutlet UILabel *favoritedCountLabel;

@property (nonatomic, strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
