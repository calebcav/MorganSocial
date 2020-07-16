//
//  Comment.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/16/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "Comment.h"
#import <Parse/Parse.h>

@implementation Comment

@dynamic commentID;
@dynamic userID;
@dynamic author;
@dynamic message;
@dynamic postID;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}




@end
