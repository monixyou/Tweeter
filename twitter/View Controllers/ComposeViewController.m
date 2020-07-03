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

- (void) actionAlert:(NSString *)title message:(NSString *)msg  {
    __weak __typeof(self) weakSelf = self;
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: title
                                   message: msg preferredStyle: UIAlertControllerStyleAlert
                                  ];
    UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Dismiss"
                              style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {}
                             ];
    [alertvc addAction: action];
    [weakSelf presentViewController: alertvc animated: true completion: nil];
}

- (IBAction)onTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.composeTextView.text completion:^(Tweet *tweet, NSError *error) {
        [self.view endEditing:YES];
        if (error) {
            NSLog(@"Error posting tweet: %@", error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            self.composeTextView.text = @"";
            [self actionAlert:@"Success" message:@"Tweet successfully sent!"];
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
