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

+ (void)createComment:(NSString *)message withPostID:(NSString * _Nullable)postID withCompletion:(PFBooleanResultBlock)completion {
    Comment *newComment = [Comment new];
    newComment.author = [PFUser currentUser];
    newComment.message = message;
    newComment.postID = postID;
    
    [newComment saveInBackgroundWithBlock:completion];
}


@end
