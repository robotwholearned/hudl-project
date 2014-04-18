//
//  ProfileViewController.h
//  hudl
//
//  Created by Cassandra Sandquist on 2014-04-17.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController : UIViewController {
    IBOutlet UIImageView* profileImageView;
    IBOutlet UIImageView* bannerImageView;

    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* usernameLabel;

    IBOutlet UILabel* tweetsLabel;
    IBOutlet UILabel* followingLabel;
    IBOutlet UILabel* followersLabel;

    IBOutlet UITextView* lastTweetTextView;
}

@property (nonatomic, retain) NSString* username;

@end
