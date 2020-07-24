//
//  Post.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/14/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "Address.h"
NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic) int likeCount;
@property (nonatomic) int commentCount;
@property (nonatomic, strong) NSMutableArray *likeList;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) Address *address;

+ (void) createPost: (NSString * _Nullable )caption withTitle: (NSString * _Nullable) title withCategory: (NSString * _Nullable)category withAddress: (Address *_Nullable)address withCompletion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
