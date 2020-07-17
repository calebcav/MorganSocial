//
//  FriendsTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setUser:(PFUser *)user {
    _user = user;
    self.friendName.text = user.username;
    self.friendPicture.file = user[@"picture"];
    [self.friendPicture loadInBackground];
}


@end
