//
//  CommentTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/16/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *commentUserPicture;
@property (strong, nonatomic) IBOutlet UILabel *commentText;
@property (strong, nonatomic) Comment *comment;
@end

NS_ASSUME_NONNULL_END
