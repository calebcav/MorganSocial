//
//  OtherUserTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 8/7/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface OtherUserTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bubblePost;
@property (strong, nonatomic) IBOutlet PFImageView *postPicture;
@property (strong, nonatomic) IBOutlet UILabel *postFullName;
@property (strong, nonatomic) IBOutlet UILabel *postUsername;
@property (strong, nonatomic) IBOutlet UILabel *postTitle;
@property (strong, nonatomic) IBOutlet UILabel *postCaption;
@property (strong, nonatomic) IBOutlet UILabel *postLocation;
@property (strong, nonatomic) IBOutlet UILabel *postCommentsCount;
@property (strong, nonatomic) IBOutlet UILabel *postLikesCount;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
