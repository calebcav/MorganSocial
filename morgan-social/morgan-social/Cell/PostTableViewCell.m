//
//  PostTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "PostTableViewCell.h"
#import "Post.h"
#import "CommentsViewController.h"

@implementation PostTableViewCell

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
    self.postUserPicture.file = post.author[@"picture"];
    [self.postUserPicture loadInBackground];
    self.postUserName.text = post.author.username;
    self.postTitle.text = post.title;
    self.postBody.text = post.caption;
    self.commentCount.text = [NSString stringWithFormat:@"%d", post.commentCount];
    self.likeCount.text = [NSString stringWithFormat:@"%d", post.likeCount];
    self.post.likeList = post.likeList;
    if ([self.post.likeList containsObject:PFUser.currentUser.username]){
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    if ([self.post.author.objectId isEqual:PFUser.currentUser.objectId]){
        [self.deleteButton setHidden:NO];
    } else {
        [self.deleteButton setHidden:YES];
    }
}

- (IBAction)deletePost:(id)sender {
    if (self.post) {
        [self.post deleteInBackground];
        NSLog(@"deleted");
    } else {
        NSLog(@"Couldn't delete post");
    }
}

- (IBAction)likePost:(id)sender {
    if (self.post) {
        if (![self.post.likeList containsObject:PFUser.currentUser.username]){
            NSLog(@"like");
            [self.post addObject:PFUser.currentUser.username forKey:@"likeList"];
            [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
            self.post.likeCount += 1;
            self.likeCount.text = [NSString stringWithFormat:@"%d", self.post.likeCount];
        }
        else {
            NSLog(@"dislike");
            self.post.likeCount -= 1;
            [self.post removeObject:PFUser.currentUser.username forKey:@"likeList"];
            [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
            self.likeCount.text = [NSString stringWithFormat:@"%d", self.post.likeCount];
        }
        NSLog(@"number after like:%lu", self.post.likeList.count);
        [self.post saveInBackground];
    }
}

@end
