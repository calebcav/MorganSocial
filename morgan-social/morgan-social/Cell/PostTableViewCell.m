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
    if ([self.post.author.objectId isEqual:PFUser.currentUser.objectId]){
        NSLog(@"Hello");
        [self.deleteButton setHidden:NO];
    } else {
        NSLog(@"God");
        [self.deleteButton setHidden:YES];
    }
}
- (IBAction)deletePost:(id)sender {
    if (self.post) {
        [self.post deleteInBackground];
        UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"Deleted Successful!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler: ^ (UIAlertAction *_Nonnull action){
        }];
        [alertvc addAction:action];
        NSLog(@"deleted");
    } else {
        NSLog(@"Couldn't delete post");
    }
}

- (IBAction)likePost:(id)sender {
    if (self.post) {
        if (![self.post.likeList containsObject:PFUser.currentUser]){
            [self.post.likeList addObject:PFUser.currentUser];
            [self.likeButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
            self.post.likeCount += 1;
        }
        else {
            self.post.likeCount -= 1;
            [self.post.likeList removeObject:PFUser.currentUser];
            [self.likeButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        }
        [self.post saveInBackground];
    }
}
@end
