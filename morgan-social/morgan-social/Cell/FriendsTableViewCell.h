//
//  FriendsTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface FriendsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet PFImageView *friendPicture;
@property (strong, nonatomic) IBOutlet UILabel *friendName;
@property (strong, nonatomic) PFUser *user;

@end

NS_ASSUME_NONNULL_END
