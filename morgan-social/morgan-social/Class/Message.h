//
//  Message.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/20/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface Message : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *sender;
@property (nonatomic, strong) PFUser *receiver;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *GIF;

+ (void) createMessage: (NSString * _Nullable)text withReceiver: (PFUser * _Nullable)receiver withGIF: (NSString *_Nullable)GIF withCompletion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
