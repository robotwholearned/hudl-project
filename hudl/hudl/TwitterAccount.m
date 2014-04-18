//
//  TwitterAccount.m
//  hudl
//
//  Created by Cassandra Sandquist on 2014-04-18.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "TwitterAccount.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@implementation TwitterAccount
- (id)initWithUsername:(NSString*)username
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.twitterHandle = username;
        [self populateAccountInfo];
    }
    return self;
}
- (void)populateAccountInfo
{
    // Request access to the Twitter accounts

    ACAccountStore* accountStore = [[ACAccountStore alloc] init];
    ACAccountType* accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    [accountStore requestAccessToAccountsWithType:accountType
                                          options:nil
                                       completion:^(BOOL granted, NSError* error) {
                                           if (granted) {
                                               
                                               NSArray *accounts = [accountStore accountsWithAccountType:accountType];
                                               
                                               // Check if the users has setup at least one Twitter account
                                               
                                               if (accounts.count > 0)
                                               {
                                                   //for simplicity first account is assumed, realistically should prompt user when there is multiple accounts, and ask which one is prefered
                                                   ACAccount *twitterAccount = [accounts objectAtIndex:0];
                                                   
                                                   // Creating a request to get the info about a user on Twitter
                                                   
                                                   SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:self.twitterHandle forKey:@"screen_name"]];
                                                   [twitterInfoRequest setAccount:twitterAccount];
                                                   
                                                   // Making the request
                                                   
                                                   [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           
                                                           // Check if we reached the rate limit
                                                           
                                                           if ([urlResponse statusCode] == 429) {
                                                               NSLog(@"Rate limit reached");
                                                               return;
                                                           }
                                                           
                                                           // Check if there was an error
                                                           
                                                           if (error) {
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               return;
                                                           }
                                                           
                                                           // Check if there is some response data
                                                           
                                                           if (responseData) {
                                                               
                                                               NSError *error = nil;
                                                               NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                                                               
                                                               
                                                               // Filter the preferred data
                                                              
                                                               self.twitterHandle = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                                                               self.fullName = [(NSDictionary *)TWData objectForKey:@"name"];
                                                               
                                                               self.followers = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
                                                               self.following = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
                                                               self.tweets = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
                                                               
                                                               self.lastTweet = [[(NSDictionary*)TWData objectForKey:@"status"] objectForKey:@"text"];
                                                               
                                                               NSString *profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
                                                               NSString *bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                                                               
                                                               
                                                               // Get the profile image in the original resolution
                                                               profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                                                               self.profileImage = [self getImageForURLString:profileImageStringURL];
                                                               
                                                               
                                                               // Get the banner image, if the user has one
                                                               NSString *bannerURLString;
                                                               if (bannerImageStringURL) {
                                                                    bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
                                                                   
                                                               }
                                                               else{
                                                                   bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", @"http://pbs.twimg.com/profile_banners/6253282/1347394302/"];
                                                               }
                                                               self.bannerImage = [self getImageForURLString:bannerURLString];
                                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"twitterAccountPopulated" object:self userInfo:nil];
                                                            }
                                                       });
                                                   }];
                                               }
                                               
                                           } else {
                                               NSLog(@"No access granted");
                                           }
                                       }];
}

- (UIImage*)getImageForURLString:(NSString*)urlString;
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSData* data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}
@end
