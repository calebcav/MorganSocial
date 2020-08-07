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
#import "Address.h"

@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likePost:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.postBubble addGestureRecognizer:tapGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postUserPicture.file = post.author[@"picture"];
    [self.postUserPicture loadInBackground];
    self.postUserPicture.layer.cornerRadius = self.postUserPicture.frame.size.width / 2;
    self.postUserPicture.clipsToBounds = YES;
    self.postUserName.text = [@"@" stringByAppendingFormat:@"%@",post.author.username];
    self.postFullName.text = [post.author[@"firstName"] stringByAppendingFormat:@" %@", post.author[@"lastName"]];
    self.postTitle.text = post.title;
    self.postBody.text = post.caption;
    self.commentCount.text = [NSString stringWithFormat:@"%d", post.commentCount];
    self.likeCount.text = [NSString stringWithFormat:@"%d", post.likeCount];
    self.post.likeList = post.likeList;
    Address *address = post.address;
    if (address.city && address.state) {
        self.postLocation.text = [address.city stringByAppendingFormat:@", %@", address.state];
    } else {
        self.postLocation.text = @"";
    }
    if ([self.post.likeList containsObject:PFUser.currentUser.username]){
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    if ([self.post.author.objectId isEqual:PFUser.currentUser.objectId]){
        [self.deleteButton setHidden:NO];
    } else {
        [self.deleteButton setHidden:YES];
    }
    self.postBubble.layer.cornerRadius = 7;
    [self.postBubble.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.postBubble.layer setShadowOpacity:0.8];
    [self.postBubble.layer setShadowRadius:3.0];
    [self.postBubble.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (IBAction)deletePost:(id)sender {
    if (self.post) {
        [self.post deleteInBackground];
        [self setHidden:YES];
    } else {
        NSLog(@"Couldn't delete post");
    }
}

- (IBAction)likePost:(id)sender {
    [self likePostHelper];
}

- (void)likePostHelper {
    if (self.post) {
        if (![self.post.likeList containsObject:PFUser.currentUser.username]){
            [self.post addObject:PFUser.currentUser.username forKey:@"likeList"];
            [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
            self.post.likeCount += 1;
            self.likeCount.text = [NSString stringWithFormat:@"%d", self.post.likeCount];
        }
        else {
            self.post.likeCount -= 1;
            [self.post removeObject:PFUser.currentUser.username forKey:@"likeList"];
            [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
            self.likeCount.text = [NSString stringWithFormat:@"%d", self.post.likeCount];
        }
        [self.post saveInBackground];
    }
}

- (void)handleDoubleTap: (UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [self likePostHelper];
    }
}

@end
