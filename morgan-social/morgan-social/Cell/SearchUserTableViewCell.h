//
//  SearchUserTableViewCell.h
//  morgan-social
//
//  Created by Caleb Caviness on 8/7/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface SearchUserTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet PFImageView *userPicture;
@property (strong, nonatomic) PFUser *user;
@end

NS_ASSUME_NONNULL_END
