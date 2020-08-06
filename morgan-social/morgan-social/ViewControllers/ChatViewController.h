//
//  ChatViewController.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@import GiphyCoreSDK;
@import GiphyUISDK;
NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, GiphyDelegate>
@property (strong, nonatomic) PFUser *friend;
@end

NS_ASSUME_NONNULL_END
