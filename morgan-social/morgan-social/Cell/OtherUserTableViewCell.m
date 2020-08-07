//
//  OtherUserTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 8/7/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "OtherUserTableViewCell.h"

@implementation OtherUserTableViewCell

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
    self.postCaption.text = self.post.caption;
    self.postTitle.text = self.post.title;
    self.postPicture.file = self.post.author[@"picture"];
    [self.postPicture loadInBackground];
    self.postFullName.text = [self.post.author[@"firstName"] stringByAppendingFormat:@" %@", self.post.author[@"lastName"]];
    self.postUsername.text = [@"@" stringByAppendingFormat:@"%@",self.post.author.username];
    self.postLocation.text = [self.post.address.city stringByAppendingFormat:@", %@", self.post.address.state];
    self.postLikesCount.text = [NSString stringWithFormat:@"%d",self.post.likeCount];
    self.postCommentsCount.text = [NSString stringWithFormat:@"%d", self.post.commentCount];
    self.bubblePost.layer.cornerRadius = 7;
    [self.bubblePost.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.bubblePost.layer setShadowOpacity:0.8];
    [self.bubblePost.layer setShadowRadius:3.0];
    [self.bubblePost.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    self.postPicture.layer.cornerRadius = self.postPicture.frame.size.width / 2;
    self.postPicture.clipsToBounds = YES;
}

@end
