//
//  Comment.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/16/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *postID;

+ (void) createComment: (NSString * _Nullable)message withPostID: (NSString * _Nullable)postID withCompletion: (PFBooleanResultBlock _Nullable) completion;


@end

NS_ASSUME_NONNULL_END
