//
//  Message.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/20/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "Message.h"
#import <Parse/Parse.h>

@implementation Message

@dynamic receiver;
@dynamic sender;
@dynamic message;

+ (nonnull NSString *)parseClassName {
    return @"Message";
}

+ (void) createMessage:(NSString *)message withReceiver:(PFUser *)receiver withCompletion:(PFBooleanResultBlock)completion {
    Message *newMessage = [Message new];
    newMessage.message = message;
    newMessage.receiver = receiver;
    newMessage.sender = [PFUser currentUser];
    
    [newMessage saveInBackgroundWithBlock:completion];
}

@end
