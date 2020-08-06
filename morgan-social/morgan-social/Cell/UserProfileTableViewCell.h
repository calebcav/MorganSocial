//
//  UserProfileTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 8/6/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface UserProfileTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *postView;
@property (strong, nonatomic) IBOutlet PFImageView *userProfilePicture;
@property (strong, nonatomic) IBOutlet UILabel *userFullName;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *postTitle;
@property (strong, nonatomic) IBOutlet UILabel *postMessage;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;
@property (strong, nonatomic) IBOutlet UILabel *commentCount;
@property (strong, nonatomic) IBOutlet UILabel *postLocation;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
