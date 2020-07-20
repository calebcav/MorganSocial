//
//  ChatTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setMessage:(Message *)message {
    _message = message;
    self.messageLabel.text = message.message;
    self.profilePicture.file = message.sender[@"picture"];
    [self.profilePicture loadInBackground];
}

@end
