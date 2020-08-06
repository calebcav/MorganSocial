//
//  UserProfileTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 8/6/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "UserProfileTableViewCell.h"

@implementation UserProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.commentCount.text = [NSString stringWithFormat:@"%d", post.commentCount];
    self.likeCount.text = [NSString stringWithFormat:@"%d", post.likeCount];
    self.postTitle.text = post.title;
    self.postMessage.text = post.caption;
    self.username.text = [@"@" stringByAppendingFormat:@"%@",post.author.username];
    self.userFullName.text = [post.author[@"firstName"] stringByAppendingFormat:@" %@", post.author[@"lastName"]];
    self.postLocation.text = [post.address.city stringByAppendingFormat:@", %@", post.address.state];
    self.userProfilePicture.file = post.author[@"picture"];
    [self.userProfilePicture loadInBackground];
    self.postView.layer.cornerRadius = 7;
    [self.postView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.postView.layer setShadowOpacity:0.8];
    [self.postView.layer setShadowRadius:3.0];
    [self.postView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

@end
