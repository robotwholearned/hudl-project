//
//  TwitterAccount.h
//  hudl
//
//  Created by Cassandra Sandquist on 2014-04-18.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterAccount : NSObject

@property (nonatomic) NSString* fullName;
@property (nonatomic) NSString* twitterHandle;
@property (nonatomic) NSString* lastTweet;
@property (nonatomic) int followers;
@property (nonatomic) int following;
@property (nonatomic) int tweets;

@property (nonatomic) UIImage* profileImage;
@property (nonatomic) UIImage* bannerImage;

- (id)initWithUsername:(NSString*)username;

@end
