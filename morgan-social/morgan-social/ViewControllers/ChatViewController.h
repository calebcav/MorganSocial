//
//  ChatViewController.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) PFUser *friend;
@end

NS_ASSUME_NONNULL_END
