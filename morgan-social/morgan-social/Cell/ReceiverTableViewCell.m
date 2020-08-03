//
//  ReceiverTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/31/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ReceiverTableViewCell.h"

@implementation ReceiverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.receiverBubble.translatesAutoresizingMaskIntoConstraints = false;
    NSArray *constraints = @[ [self.receiverText.widthAnchor constraintLessThanOrEqualToConstant:250],
    [self.receiverBubble.topAnchor constraintEqualToAnchor:self.receiverText.topAnchor constant:-16],
    [self.receiverBubble.bottomAnchor constraintEqualToAnchor:self.receiverText.bottomAnchor constant:16],
    [self.receiverBubble.leadingAnchor constraintEqualToAnchor:self.receiverText.leadingAnchor constant:-16],
    [self.receiverBubble.trailingAnchor constraintEqualToAnchor:self.receiverText.trailingAnchor constant:16]];
    self.receiverBubble.layer.cornerRadius = 7;
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setMessage:(Message *)message {
    _message = message;
    self.receiverText.text = message.text;
    [self.receiverBubble.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.receiverBubble.layer setShadowOpacity:0.8];
    [self.receiverBubble.layer setShadowRadius:3.0];
    [self.receiverBubble.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

@end
