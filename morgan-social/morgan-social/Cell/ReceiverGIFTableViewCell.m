//
//  ReceiverGIFTableViewCell.m
//  morgan-social
//
//  Created by Caleb Caviness on 8/6/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ReceiverGIFTableViewCell.h"

@implementation ReceiverGIFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(Message *)message {
    _message = message;
    NSString *url = [@"https://media0.giphy.com/media/" stringByAppendingFormat:@"%@/giphy.gif", message.GIF];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    self.gifImage.animatedImage = image;
}

@end
