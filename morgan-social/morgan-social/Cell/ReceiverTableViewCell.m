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
    self.receiverBubble.layer.masksToBounds = NO;
    self.receiverBubble.layer.shadowOffset = CGSizeMake(.0f, 2.5f);
    self.receiverBubble.layer.shadowRadius = 1.5f;
    self.receiverBubble.layer.shadowOpacity = .9f;
    self.receiverBubble.layer.shadowColor = [UIColor colorWithRed:176.f/255.f green:199.f/255.f blue:226.f/255.f alpha:1.f].CGColor;
}

@end
