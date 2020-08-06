//
//  ReceiverGIFTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 8/6/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import <FLAnimatedImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface ReceiverGIFTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) Message *message;
@end

NS_ASSUME_NONNULL_END
