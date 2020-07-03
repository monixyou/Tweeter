//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Monica Bui on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetDetailsViewControllerDelegate

- (void)didReply:(Tweet *)tweet;

@end


@interface TweetDetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id<TweetDetailsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
