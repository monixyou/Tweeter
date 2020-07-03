//
//  ComposeViewController.m
//  
//
//  Created by Monica Bui on 6/30/20.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *composeTextView;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeTextView.layer.borderWidth = 1.0f;
    self.composeTextView.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (IBAction)onClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.composeTextView.text completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error posting tweet: %@", error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            NSLog(@"Successfully tweeted! Tweet: %@", tweet.text);
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
