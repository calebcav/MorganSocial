//
//  CommentTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/16/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setComment:(Comment *)comment {
    _comment = comment;
    self.commentText.text = comment.message;
    self.commentUserPicture.file = comment.author[@"picture"];
    self.commentUserPicture.layer.cornerRadius = self.commentUserPicture.frame.size.width /2;
    [self.commentUserPicture loadInBackground];
    self.commentUsername.text = comment.author.username;
}

@end
