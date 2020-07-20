//
//  ChatTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface ChatTableViewCell : UITableViewCell
@property (strong, nonatomic) Message *message;
@property (strong, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;


@end

NS_ASSUME_NONNULL_END
