//
//  CommentsViewController.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/16/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Post *post;
@end

NS_ASSUME_NONNULL_END
