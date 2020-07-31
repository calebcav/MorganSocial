//
//  SenderTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/31/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "SenderTableViewCell.h"

@implementation SenderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.senderBubble.backgroundColor = [UIColor blueColor];
    self.senderBubble.translatesAutoresizingMaskIntoConstraints = false;
    self.senderMessage.translatesAutoresizingMaskIntoConstraints = false;
    NSArray *constraints = @[[self.senderMessage.widthAnchor constraintLessThanOrEqualToConstant:250],
        [self.senderBubble.topAnchor constraintEqualToAnchor:self.senderMessage.topAnchor constant:-16],
    [self.senderBubble.bottomAnchor constraintEqualToAnchor:self.senderMessage.bottomAnchor constant:16],
    [self.senderBubble.leadingAnchor constraintEqualToAnchor:self.senderMessage.leadingAnchor constant:-16],
    [self.senderBubble.trailingAnchor constraintEqualToAnchor:self.senderMessage.trailingAnchor constant:16]];
    self.senderBubble.layer.cornerRadius = 7;
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setMessage:(Message *)message {
    _message = message;
    self.senderMessage.text = message.text;
    self.senderMessage.textColor = [UIColor whiteColor];
}

@end
