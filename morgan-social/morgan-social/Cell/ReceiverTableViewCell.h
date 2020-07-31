//
//  ReceiverTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/31/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface ReceiverTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *receiverText;
@property (strong, nonatomic) Message *message;
@property (strong, nonatomic) IBOutlet UIView *receiverBubble;

@end

NS_ASSUME_NONNULL_END
