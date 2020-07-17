//
//  CreatePostViewController.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CreatePostViewControllerDelegate
- (void)didPost;
@end

@interface CreatePostViewController : UIViewController
@property (nonatomic, weak) id<CreatePostViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
