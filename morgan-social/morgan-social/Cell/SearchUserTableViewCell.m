//
//  SearchUserTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 8/7/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "SearchUserTableViewCell.h"

@implementation SearchUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.addButton setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(PFUser *)user {
    _user = user;
    self.username.text = user.username;
    self.userPicture.file = user[@"picture"];
    [self.userPicture loadInBackground];
    self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width / 2;
    self.userPicture.clipsToBounds = YES;
    if ([PFUser.currentUser[@"Friends"] containsObject:user]) {
        [self.addButton setImage:[UIImage imageNamed:@"subtract"] forState:UIControlStateNormal];
    } else {
        [self.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }
}

- (IBAction)addFriend:(id)sender {
    if ([PFUser.currentUser[@"Friends"] containsObject:self.user]) {
        [self.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [PFUser.currentUser[@"Friends"] addObject:self.user];
    } else {
        [self.addButton setImage:[UIImage imageNamed:@"subtract"] forState:UIControlStateNormal];
        [PFUser.currentUser[@"Friends"] removeObject:self.user];
    }
    [PFUser.currentUser saveInBackground];
}


@end
