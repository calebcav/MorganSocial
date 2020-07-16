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
    if ([self.post.author.objectId isEqual:PFUser.currentUser.objectId]){
        [self.deleteButton setHidden:NO];
    } else {
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




@end
