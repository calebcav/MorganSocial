//
//  PostTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewCell : UITableViewCell
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *postUserPicture;
@property (strong, nonatomic) IBOutlet UILabel *postUserName;
@property (strong, nonatomic) IBOutlet UILabel *postTitle;
@property (strong, nonatomic) IBOutlet UILabel *postBody;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;
@property (strong, nonatomic) IBOutlet UILabel *commentCount;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UILabel *postFullName;
@property (strong, nonatomic) IBOutlet UIView *postBubble;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;

@end

NS_ASSUME_NONNULL_END
