//
//  ProfileViewController.m
//  hudl
//
//  Created by Cassandra Sandquist on 2014-04-17.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterAccount.h"
#import "MBProgressHUD.h"

@interface ProfileViewController () {
    TwitterAccount* requestedUserAccount;
}
@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.labelText = @"gathering information";
    requestedUserAccount = [[TwitterAccount alloc] initWithUsername:self.username];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(twitterAccountPopulated:)
                                                 name:@"twitterAccountPopulated"
                                               object:nil];
    [profileImageView.layer setBorderWidth:4.0f];
    [profileImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];

    [profileImageView.layer setShadowRadius:3.0];
    [profileImageView.layer setShadowOpacity:0.5];
    [profileImageView.layer setShadowOffset:CGSizeMake(1.0, 0.0)];
    [profileImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
}
- (void)twitterAccountPopulated:(NSNotification*)notification
{
    // Update the interface with the loaded data

    NSLog(@"Acount Populated!!!!!");
    nameLabel.text = requestedUserAccount.fullName;
    usernameLabel.text = [NSString stringWithFormat:@"@%@", requestedUserAccount.twitterHandle];
    tweetsLabel.text = [NSString stringWithFormat:@"%i", requestedUserAccount.tweets];
    followingLabel.text = [NSString stringWithFormat:@"%i", requestedUserAccount.following];
    followersLabel.text = [NSString stringWithFormat:@"%i", requestedUserAccount.followers];
    lastTweetTextView.text = requestedUserAccount.lastTweet;
    profileImageView.image = requestedUserAccount.profileImage;
    bannerImageView.image = requestedUserAccount.bannerImage;
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
