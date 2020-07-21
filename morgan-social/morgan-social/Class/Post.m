//
//  Post.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/14/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "Post.h"
#import <Parse/Parse.h>

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic likeCount;
@dynamic commentCount;
@dynamic title;
@dynamic category;
@dynamic likeList;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void)createPost:(NSString *)caption withTitle:(NSString * _Nullable)title withCategory:(NSString *_Nullable)category withCompletion:(PFBooleanResultBlock)completion {
    Post *newPost = [Post new];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = 0;
    newPost.commentCount = 0;
    newPost.title = title;
    newPost.category = category;
    newPost.likeList = [NSMutableArray new];
    
    [newPost saveInBackgroundWithBlock: completion];
}

@end
