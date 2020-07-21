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
@dynamic text;

+ (nonnull NSString *)parseClassName {
    return @"Message";
}

+ (void) createMessage:(NSString *)text withReceiver:(PFUser *)receiver withCompletion:(PFBooleanResultBlock)completion {
    Message *newMessage = [Message new];
    newMessage.text = text;
    newMessage.receiver = receiver;
    newMessage.sender = [PFUser currentUser];
    
    [newMessage saveInBackgroundWithBlock:completion];
}

@end
