//
//  Post.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/14/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) createPost: (NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
